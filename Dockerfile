# Base Image (CUDA for GPU acceleration)
FROM nvidia/cuda:11.8.0-devel-ubuntu22.04

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 python3-pip git ffmpeg libsm6 libxext6 libgl1-mesa-glx && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Install Python dependencies
RUN pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
RUN pip3 install diffusers transformers accelerate scipy numpy pillow opencv-python flask

# Clone the model
RUN git clone https://huggingface.co/stabilityai/stable-video-diffusion-img2vid

# Copy the API script
COPY app.py .

# Expose the API port
EXPOSE 5000

# Run the API
CMD ["python3", "app.py"]
