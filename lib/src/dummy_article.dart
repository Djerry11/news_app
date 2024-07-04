// Define the source object
import 'package:news_app/src/core/models/articles.dart';
import 'package:news_app/src/core/models/source.dart';

const Source techCrunchSource = Source(
  id: 'techcrunch',
  name: 'TechCrunch',
);

// Define the article object using the given information
const Articles dummyArticle = Articles(
  source: techCrunchSource,
  author: 'Lauren Forristal',
  title:
      "Bye-bye bots: Altera's game-playing AI agents get backing from Eric Schmidt | TechCrunch",
  description:
      "Autonomous, AI-based players are coming to a gaming experience near you, and a new startup, Altera, is joining the fray to build this new guard of AI Research company Altera raised \$9 million to build AI agents that can play video games alongside other players.",
  url:
      "https://techcrunch.com/2024/05/08/bye-bye-bots-alteras-game-playing-ai-agents-get-backing-from-eric-schmidt/",
  urlToImage:
      "https://techcrunch.com/wp-content/uploads/2024/05/Minecraft-keyart.jpg?resize=1200,720",
  publishedAt: "2024-05-08T15:14:57Z",
  isBookmarked: false,
);
