import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const QuestionApp());
}

void appToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      fontSize: 28.0
  );
}

class Answer {
  final String description;
  final bool answer;
  Answer(this.description, this.answer);
}


class Question {
  final String description;
  final Answer answer;
  Question(this.description, this.answer);

  static Question empty() {
    return Question("", Answer("", false));
  }
}


class QuestionWidget extends StatelessWidget {
  final Question question;
  const QuestionWidget({Key? key, required this.question, required this.answerQuestion}) : super(key: key);
  final Function(bool, Question) answerQuestion;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          question.description,
          style: const TextStyle(
              fontSize: 20
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 10.0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => answerQuestion(true, question),
              child: const Text("True"),
            ),
            const Padding(padding: EdgeInsets.only(right: 16.0)),
            ElevatedButton(
              onPressed: () => answerQuestion(false, question),
              child: const Text("False"),
            ),
          ],
        )
      ],
    );
  }
}


class EndWidget extends StatelessWidget {
  const EndWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Congratulations, you win!",
      style: TextStyle(
        fontSize: 24
      ),
    );
  }
}



class QuestionApp extends StatefulWidget {
  const QuestionApp({Key? key}) : super(key: key);
  
  @override
  State<QuestionApp> createState() => _QuestionAppState();
}

class _QuestionAppState extends State<QuestionApp> {
  final List<Question> questions = [
    Question("is Lima the capital of Peru?", Answer("", true)),
    Question("is New York the capital of United States?", Answer("", false)),
    Question("is Florida the capital of Mexico?", Answer("", false)),
    Question("is Bangladesh the capital of Arabia Saudi?", Answer("", false)),
    Question("is Tokio the capital of Japan?", Answer("", true)),
  ];

  int index = 0;

  void answerQuestion(bool answer, Question question) {
    if(answer == question.answer.answer) {
      appToast("It's correct");
      setState(() {
        index += 1;
      });
    } else {
      appToast("It's incorrect");
    }
  }

  Question getQuestion() {
    if(isIndexValid()) {
      return questions[index];
    }
    return Question.empty();
  }

  bool isIndexValid() {
    return index < questions.length;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Questions app"),
        ),
        body: Center(
          child: isIndexValid()
          ? QuestionWidget(question: getQuestion(), answerQuestion: answerQuestion,)
          : const EndWidget(),
        ),
      ),
    );
  }
}


