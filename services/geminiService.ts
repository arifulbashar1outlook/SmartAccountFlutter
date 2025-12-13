import { GoogleGenAI } from "@google/genai";
import { Transaction } from '../types';

const ai = new GoogleGenAI({ apiKey: process.env.API_KEY });

export const getFinancialAdvice = async (transactions: Transaction[]): Promise<string> => {
  if (transactions.length === 0) {
    return "Please add some transactions to receive AI-powered financial advice.";
  }

  // Limit the context size for efficiency, taking the last 50 transactions
  const recentTransactions = transactions
    .sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime())
    .slice(0, 50);

  const prompt = `
    You are a financial advisor. Analyze the following list of recent financial transactions (JSON format).
    
    Transactions:
    ${JSON.stringify(recentTransactions)}

    Please provide a concise analysis in Markdown format:
    1. Identify the top spending category.
    2. Point out any unusual spending patterns or frequent small expenses.
    3. Give one specific, actionable tip to improve savings based on this data.
    4. Keep the tone encouraging but professional.
    5. Keep it under 200 words.
  `;

  try {
    const response = await ai.models.generateContent({
      model: 'gemini-2.5-flash',
      contents: prompt,
    });
    
    return response.text || "Could not generate advice at this time.";
  } catch (error) {
    console.error("Gemini API Error:", error);
    return "Sorry, I'm having trouble analyzing your data right now. Please try again later.";
  }
};

export const categorizeDescription = async (description: string): Promise<string | null> => {
  try {
     const response = await ai.models.generateContent({
      model: 'gemini-2.5-flash',
      contents: `Categorize this expense description into a single short category name (e.g. 'Food', 'Transport', 'Utilities'). Description: "${description}". Return ONLY the category word.`,
    });
    return response.text?.trim() || null;
  } catch (e) {
    return null;
  }
}