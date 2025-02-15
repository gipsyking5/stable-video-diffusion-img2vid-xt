from inference import img2vid_xt  # Import model function
import base64
from io import BytesIO
from PIL import Image
import runpod

def handler(job):
    data = job["input"]
    image_base64 = data.get("image")
    motion_bucket_id = data.get("motion_bucket_id", 127)
    cond_aug = data.get("cond_aug", 0.02)

    # Decode base64 image
    image_bytes = BytesIO(base64.b64decode(image_base64))
    input_image = Image.open(image_bytes).convert("RGB")

    # Generate video
    video_path = img2vid_xt(input_image, motion_bucket_id, cond_aug)

    return {"video": video_path}

runpod.serverless.start({"handler": handler})
