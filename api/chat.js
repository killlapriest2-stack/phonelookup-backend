export default async function handler(req, res) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    const { message } = req.body;

    // Тут інтеграція з OpenAI API
    // приклад-заглушка:
    res.status(200).json({ reply: `Echo: ${message}` });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Server error' });
  }
}
