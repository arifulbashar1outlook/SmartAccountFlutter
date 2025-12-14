import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  late GenerativeModel _model;

  GeminiService(String apiKey) {
    _model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
  }

  Future<String> getFinancialAdvice(String financialData) async {
    try {
      final prompt = '''
Based on the following financial data, provide concise and actionable financial advice in markdown format:

$financialData

Please provide:
1. Key insights about spending patterns
2. Areas where money could be saved
3. Recommendations for budgeting
4. Suggestions for building savings

Keep the response focused and practical.
      ''';

      final response = await _model.generateContent([Content.text(prompt)]);
      
      if (response.text != null) {
        return response.text!;
      }
      return 'Unable to generate financial advice at this time.';
    } catch (e) {
      print('Error getting financial advice: $e');
      return 'Error generating financial advice: $e';
    }
  }

  Future<String> analyzeCategory(String category, List<String> transactions) async {
    try {
      final transactionList = transactions.join('\n');
      final prompt = '''
Analyze the following $category transactions and provide insights:

$transactionList

Provide brief analysis about spending patterns and suggestions.
      ''';

      final response = await _model.generateContent([Content.text(prompt)]);
      return response.text ?? 'No analysis available';
    } catch (e) {
      print('Error analyzing category: $e');
      return 'Error analyzing: $e';
    }
  }
}
