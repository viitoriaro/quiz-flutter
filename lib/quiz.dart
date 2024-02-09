import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});
  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int currentQuestionIndex = 0;
  int point = 0;
  String? selectedAnswer;
  bool? isCorrect;
  final List<Map<String, dynamic>> questions = [
    {
      'question':
          'Qual é o maior mamífero marinho?',
      'answers': [
        'Baleia-azul',
        'Polvo',
        'Tubarão',
        'Lula',
      ],
      'correctAnswer': 'Baleia-azul'
    },
    {
      'question':
          'Qual é o maior peixe do oceano?',
      'answers': [
        'Caranguejo',
        'Baleia tubarão',
        'Tartaruga Marinha',
        'Baleia',
      ],
      'correctAnswer': 'Baleia tubarão'
    },
    {
      'question':
          'Quem é conhecido como "gato do mar"?',
      'answers': [
        'Polvo',
        'Lula',
        'Manati',
        'Água-viva',
      ],
      'correctAnswer': 'Manati',
    },
    {
      'question':
          'Qual é o maior predador marinho?',
      'answers': [
        'Barracuda',
        'Lula',
        'Peixe-lanterna',
        'Baleia-orca',
      ],
      'correctAnswer': 'Baleia-orca',
    },
    {
      'question':
          'Quem é conhecido como "Rei dos oceanos"?',
      'answers': [
        'Baleia Azul',
        'Tubarão-Branco',
        'Tubarão Martelo',
        'Peixe-palhaço',
      ],
      'correctAnswer': 'Tubarão-Branco',
    },
  ];
  void handleAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
      isCorrect = answer == questions[currentQuestionIndex]['correctAnswer'];
    });
    Future.delayed(const Duration(seconds: 1), () {
  setState(() {
    selectedAnswer = null;
    isCorrect = null;
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
    } else {
      // Se for a última pergunta, exiba uma mensagem de agradecimento
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Você acabou!", style: GoogleFonts.poppins()),
            content: Text("Vá para o próximo!", style: GoogleFonts.poppins()),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  // Navegue de volta para a HomePage
                  Navigator.of(context).popUntil(ModalRoute.withName('/'));
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  });
});
  }


  @override
  Widget build(BuildContext context) {
    var currentQuestion = questions[currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Quiz marítimo!',
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.w400))),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            color: Colors.grey[100],
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Center(
              child: Text(
                currentQuestion['question'],
                style: GoogleFonts.poppins(
                    color: Colors.black, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Wrap(
              children: currentQuestion['answers'].map<Widget>((resposta) {
            bool isSelected = selectedAnswer == resposta;
            Color? buttonColor;
            if (isSelected) {
              buttonColor = isCorrect! ? Colors.green : Colors.red;
              isCorrect! ? point++ : null;
            } else {
              buttonColor = Colors.grey[800];
            }
            return meuBtn(resposta, () => handleAnswer(resposta), buttonColor);
          }).toList()),
        ],
      ),
    );
  }
}

Widget meuBtn(String resposta, VoidCallback onPressed, Color? color) =>
    Container(
      margin: const EdgeInsets.all(16),
      width: 140,
      height: 80,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: color, padding: const EdgeInsets.all(16)),
        child: Text(
          resposta,
          style: GoogleFonts.poppins(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );