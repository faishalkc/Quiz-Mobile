import 'package:flutter/material.dart';
import 'constants.dart';
import 'models/question_model.dart';
import 'widgets/question_widget.dart';
import 'widgets/next_button.dart';
import 'widgets/option_card.dart';
import 'widgets/result_box.dart';
import 'models/db_connect.dart';

class InPage extends StatefulWidget {
  const InPage({Key? key}) : super(key: key);

  @override
  State<InPage> createState() => _InPageState();
}

class _InPageState extends State<InPage> {
  var db = DBconnect();
  late Future _questions;

  Future<List<Question>> getData() async {
    return db.fetchQuestion();
  }

  @override
  void initState() {
    _questions = getData();
    super.initState();
  }

  int index = 0;
  int score = 0;

  bool isPressed = false;
  bool isAlreadySelected = false;

  void checkAnswerAndUpdate(bool value) {
    if (isAlreadySelected) {
      return;
    } else {
      if (value == true) {
        score++;
      }
      setState(() {
        isPressed = true;
        isAlreadySelected = true;
      });
    }
  }

  void nextQuestion(int questionLength) {
    if (index == questionLength - 1) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => ResultBox(
                result: score,
                questionLength: questionLength,
                onPressed: startOver,
              ));
    } else {
      setState(() {
        if (isPressed) {
          index++;
          isPressed = false;
          isAlreadySelected = false;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Please select any option'),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10)));
        }
      });
    }
  }

  void startOver() {
    setState(() {
      index = 0;
      score = 0;
      isPressed = false;
      isAlreadySelected = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _questions as Future<List<Question>>,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            var extractedData = snapshot.data as List<Question>;
            if (isAlreadySelected == false) {
              if (index == 0) {
                extractedData.shuffle();
              }
            }
            var randomData = extractedData;
            var fixedData = randomData;
            return Scaffold(
              backgroundColor: background,
              appBar: AppBar(
                title: const Text("Quiz"),
                backgroundColor: background,
                shadowColor: Colors.transparent,
                actions: [
                  Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text('Score: $score',
                          style: const TextStyle(fontSize: 18.0)))
                ],
              ),
              body: Container(
                decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/quiz.png'),
          fit: BoxFit.cover,
          ),
        ),
                child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          QuestionWidget(
                            indexAction: index,
                            question: fixedData[index].title,
                            totalQuestions: fixedData.length,
                          ),
                          const Divider(color: neutral),
                          const SizedBox(height: 15.0),
                          for (int i = 0;
                              i < fixedData[index].options.length;
                              i++)
                            GestureDetector(
                              onTap: () => checkAnswerAndUpdate(
                                  fixedData[index].options.values.toList()[i]),
                              child: OptionCard(
                                option: fixedData[index].options.keys.toList()[i],
                                color: isPressed
                                    ? fixedData[index]
                                                .options
                                                .values
                                                .toList()[i] ==
                                            true
                                        ? correct
                                        : incorrect
                                    : neutral,
                              ),
                            )
                        ],
                      ),
                    )),
              ),
              floatingActionButton: GestureDetector(
                onTap: () => nextQuestion(fixedData.length),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: NextButton(),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const Center(
          child: Text('No Data'),
        );
      },
    );
  }
}
