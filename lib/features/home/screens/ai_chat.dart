import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mera_app/core/theme/app_color.dart';
import 'package:mera_app/features/home/bloc/ai_chat_bloc.dart';
import 'package:mera_app/features/home/bloc/ai_chat_event.dart';
import 'package:mera_app/features/home/bloc/ai_chat_state.dart';

class AiChat extends StatelessWidget {
  const AiChat({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController userPromptController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Ai chat',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              height: 1,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              color: Colors.black.withOpacity(0.1),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: BlocBuilder<AiChatBloc, AiChatState>(
            builder: (context, state) {
              final messages = state.messages;
              if (messages.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "💡 What can I help you with today?\nAsk me about food or cooking!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                );
              }
              return ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  itemCount: messages.length + (state.isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (state.isLoading && index == messages.length) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 8,
                                backgroundColor: Colors.black,
                                child: Icon(
                                  Icons.smart_toy,
                                  color: Colors.white,
                                  size: 12,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                state.loadingStage,
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                    final message = messages[index];
                    final isUser = message['isUser'] as bool;
                    if (isUser) {
                      return Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                              color: AppColors.primaryOrange,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  topRight: Radius.circular(0))),
                          child: Text(
                            message['text'],
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              radius: 8,
                              backgroundColor: Colors.black,
                              child: Icon(
                                Icons.smart_toy,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                                child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(16),
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16),
                                    topLeft: Radius.circular(0),
                                  )),
                              child: Text(
                                message['text'],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ))
                          ],
                        ),
                      );
                    }
                  });
            },
          )),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20)),
                  child: TextField(
                    controller: userPromptController,
                    decoration: const InputDecoration(
                        hintText: "Type something...",
                        border: InputBorder.none),
                  ),
                )),
                const SizedBox(width: 6),
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.primaryOrange,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                      onPressed: () {
                        final prompt = userPromptController.text.trim();
                        if (prompt.isNotEmpty) {
                          context
                              .read<AiChatBloc>()
                              .add(GenerateContentEvent(prompt));
                          userPromptController.clear();
                        }
                      },
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
