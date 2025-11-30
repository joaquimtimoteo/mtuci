
## Prerequisites

* Python 3.10+
* Ollama installed and running
* Virtual environment recommended

---

## Setup Guide

### 1. Verify Ollama Installation

```bash
ollama --version
```

### 2. Start the Ollama Server

```bash
ollama serve &
```

### 3. Test the Model

```bash
ollama run qwen2:0.5b
```

### 4. Connect via SSH (if using MicroVM)

**Terminal 1 – Keep SSH tunnel open**

```bash
fly proxy 2222:2222 -a minha-vm-python
```

**Terminal 2 – Connect to the VM**

```bash
ssh student@localhost -p 2222
```

### 5. Navigate to Project Folder

```bash
cd /app/gpt2-simple
```

### 6. Activate Python Virtual Environment

```bash
source venv/bin/activate
```

### 7. Install Python Dependencies

```bash
pip install ollama
```

### 8. Run the Chat

```bash
python chat_ollama.py
```

---

## Usage

* Type messages and get responses from the AI.
* Commands:

  * `quit` / `exit` → Exit the chat
  * `clear` → Clear conversation history

The AI’s personality can be set in the script at the `system` role:

```python
conversation = [
    {
        'role': 'system',
        'content': "You are a funny and playful assistant. Always make witty or humorous remarks in your replies."
    }
]
```
