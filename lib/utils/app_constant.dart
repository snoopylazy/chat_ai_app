import 'dart:math';

import 'package:flutter/material.dart';

class AppConstant {
  static final List<Map<String, dynamic>> defaultQues = [
    {
      "title": "Most Popular",
      "question": [
        {
          "icon": Icons.ac_unit,
          "color": Colors.primaries[Random().nextInt(Colors.primaries.length)],
          "ques": "What is AI?"
        },
        {
          "icon": Icons.emoji_emotions_rounded,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "Tell me a jock?"
        },
        {
          "icon": Icons.computer,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "Explain me the concept of Machine Learning?"
        },
        {
          "icon": Icons.cloud,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "How does Climate change work?"
        },
        {
          "icon": Icons.label,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "What is the meaning of life?"
        },
        {
          "icon": Icons.games_sharp,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "How can I improve my writing skills?"
        },
        {
          "icon": Icons.terrain,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "What are effective strategies to boost productivity?"
        },
        {
          "icon": Icons.nature_outlined,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "Explain quantum mechanics in simple terms."
        }
      ]
    },
    {
      "title": "Trending",
      "question": [
        {
          "icon": Icons.question_mark,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "Explain the theory of relativity in simple terms?."
        },
        {
          "icon": Icons.swap_horizontal_circle_outlined,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "What is blockchain technology and how does it work?"
        },
        {
          "icon": Icons.equalizer_rounded,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "What are effective strategies for improving time management?"
        },
      ]
    },
    {
      "title": "Instagram",
      "question": [
        {
          "icon": Icons.trending_up_rounded,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "What are the latest Instagram trends?"
        },
        {
          "icon": Icons.align_horizontal_center_outlined,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "How does the Instagram algorithm work in 2025?"
        },
        {
          "icon": Icons.video_collection_outlined,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "How can I make my Instagram Reels go viral?"
        },
        {
          "icon": Icons.monetization_on_outlined,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "How do I make money on Instagram?"
        },
      ]
    }
  ];
}
