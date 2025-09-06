import 'package:flutter/material.dart';
import 'package:mera_app/core/theme/app_color.dart';

class AiChat extends StatelessWidget {
  const AiChat({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> messages = [
      {'text': 'How do I boil an egg properly?', 'isUser': true},
      {
        'text':
            'To boil eggs, place them in a pot of cold water and bring to a boil.',
        'isUser': false
      },
      {'text': 'How long should I keep them boiling?', 'isUser': true},
      {
        'text': 'For soft-boiled: 6 minutes. For hard-boiled: 10–12 minutes.',
        'isUser': false
      },
      {'text': 'Should I add salt or vinegar to the water?', 'isUser': true},
      {
        'text':
            'Yes, adding a little salt or vinegar helps prevent cracks and makes peeling easier.',
        'isUser': false
      },
      {'text': 'What’s the best way to peel them?', 'isUser': true},
      {
        'text':
            'Cool them in ice water for 5 minutes, then gently tap and roll to peel.',
        'isUser': false
      },
      {'text': 'Perfect, thanks! Now I can make egg salad.', 'isUser': true},
      {
        'text':
            'Great! Try mixing boiled eggs with mayo, mustard, and a pinch of pepper for a tasty salad.',
        'isUser': false
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'ChatAi',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_sharp)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.info_outline,
              color: Colors.black,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    title: const Text("Food Bot Info"),
                    content: const Text(
                      "👨‍🍳 Welcome to Food Chat!\n\n"
                      "You can ask me about:\n"
                      "- How to cook or boil food\n"
                      "- Best recipes for quick meals\n"
                      "- Healthy eating tips\n"
                      "- Food safety and storage\n\n"
                      "Just type your question below and I’ll guide you 🍲",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Got it!"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final messge = messages[index];
                    final isUser = messge['isUser'] as bool;
                    return Align(
                      alignment:
                          isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                            color: isUser
                                ? AppColors.primaryOrange
                                : Colors.grey[200],
                            borderRadius: BorderRadius.only(
                                bottomLeft: const Radius.circular(16),
                                bottomRight: const Radius.circular(16),
                                topLeft: isUser
                                    ? const Radius.circular(16)
                                    : const Radius.circular(0),
                                topRight: isUser
                                    ? const Radius.circular(0)
                                    : const Radius.circular(16))),
                        child: Text(
                          messge['text'],
                          style: TextStyle(
                              color: isUser ? Colors.white : Colors.black),
                        ),
                      ),
                    );
                  })),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                        hintText: "Type something...",
                        border: InputBorder.none),
                  ),
                )),
                const SizedBox(width: 8),
                Container(
                  decoration: const BoxDecoration(
                      color: AppColors.primaryOrange, shape: BoxShape.circle),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
