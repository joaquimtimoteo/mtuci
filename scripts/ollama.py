import ollama

print("=" * 70)
print("🤖 LOCAL AI CHAT - Qwen2 0.5B Model")
print("=" * 70)
print("\n💡 This AI runs 100% locally on your MicroVM!")
print("📊 Model: 494M parameters, 330MB size")
print("\nType 'quit' to exit, 'clear' to reset conversation\n")
print("-" * 70)

model = "qwen2:0.5b"
conversation = []

while True:
    user_input = input("\n😊 You: ").strip()
    
    if not user_input:
        continue
    
    if user_input.lower() in ['quit', 'exit', 'q']:
        print("\n👋 Goodbye! Thanks for chatting!\n")
        break
    
    if user_input.lower() == 'clear':
        conversation = []
        print("🔄 Conversation cleared!")
        continue
    
    # Adicionar ao histórico
    conversation.append({
        'role': 'user',
        'content': user_input
    })
    
    print("\n🤖 AI: ", end="", flush=True)
    
    try:
        # Gerar resposta com streaming
        stream = ollama.chat(
            model=model,
            messages=conversation,
            stream=True
        )
        
        full_response = ""
        for chunk in stream:
            content = chunk['message']['content']
            print(content, end="", flush=True)
            full_response += content
        
        print()  # Nova linha
        
        # Adicionar resposta ao histórico
        conversation.append({
            'role': 'assistant',
            'content': full_response
        })
        
    except Exception as e:
        print(f"\n\n❌ Error: {e}")
        print("💡 Make sure Ollama is running: ollama serve")
        conversation.pop()  # Remove última mensagem

print("\n" + "=" * 70)
