from telegram.ext import ApplicationBuilder, CommandHandler
from config import API_TOKEN
from handlers import start, help_command, send_hint, send_article, feedback

def main():
    app = ApplicationBuilder().token(API_TOKEN).build()

    app.add_handler(CommandHandler("start", start))
    app.add_handler(CommandHandler("help", help_command))
    app.add_handler(CommandHandler("hint", send_hint))
    app.add_handler(CommandHandler("article", send_article))
    app.add_handler(CommandHandler("feedback", feedback))

    app.run_polling()

if __name__ == '__main__':
    main()
