
/**
*  Description: Handle everything to do with twitter.
*
*  Creator:     Skyler Layne (@skylerto)
*  Version:     0.1
*/
class TwitterHandler {
  
  // Needed objects
  private Twitter twitter;

  // Class attributes
  private StringList hashtags;
  private ArrayList tweetees;
  private String currentHashTag;
  private ArrayList tweets;
  
  int hashSize = 0;
  
  public TwitterHandler(StringList hashtags){
    
    tweets = new ArrayList();
    
    this.currentHashTag = ""; 
    this.hashtags = hashtags;
    this.tweetees = new ArrayList();
    
    ConfigurationBuilder cb = new ConfigurationBuilder();
    cb.setOAuthConsumerKey("*******************");
    cb.setOAuthConsumerSecret("****************");
    cb.setOAuthAccessToken("*******************");
    cb.setOAuthAccessTokenSecret("*************");
    this.twitter = new TwitterFactory(cb.build()).getInstance(); 
  }
  
  /**
  *  Returns the size of the tweetees array
  */
  public int getTweeteesSize(){
   return this.tweetees.size(); 
  }
  
  /**
  *  Return the amount of hashtags in the hashtag list
  */
  public int getAmountOfHashtags(){
   return this.hashtags.size(); 
  }
  
  /**
  *  gets the tweet at the indicated index
  */
  public String getTweet(int index){
    TweetWord tweetword = (TweetWord) tweetees.get(index);
    return tweetword.getText();
  }
  
  /**
  *  Determine if there is a tweet
  */
  public boolean hasTweets(){
   return tweetees.size() - 1 > 0;
  }
  
  /**
  *  Search twitter for a list of tweets
  */
  public void queryTwitter()
  {
    currentHashTag = hashtags.get((int) random(0, this.getAmountOfHashtags()));
    
    Query query = new Query(currentHashTag);
    query.count(7);

    try {
      // search twitter for the hashtag at randomvar
      QueryResult result = twitter.search(query);
      
      // put ALL instances of found tweets in arraylist "tweets" & iterate 
      tweets = (ArrayList) result.getTweets();
      int numberOfTweets = tweets.size();
      println("Number of tweets available: " + (numberOfTweets));
      for (int i = 0; i < numberOfTweets; i++)
      {
        // create a username & status encapsulated in "twit" tweet object
        // add all "twits" to an arraylist of tweet objects called "tweetees"
        // haha
        Status status = (Status) tweets.get(i);
        User user = (User) status.getUser();
        String msg = status.getText();
        String name = user.getScreenName();
        TweetWord twit = new TweetWord(name, msg);
        tweetees.add(twit);
      }
    } 
    catch (TwitterException e) {
      println("Couldn't connect: " + e);
    }
  }
  
  /**
  *  Get the current hashtag 
  */
  public String getCurrentHashTag() {
   return this.currentHashTag; 
  }
  
  /**
  *  Get the current list of tweetees
  */
  public ArrayList getTweetees() {
   return this.tweetees; 
  }
}
