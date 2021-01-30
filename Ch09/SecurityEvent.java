public class SecurityEvent

 {

  private String mSrcip;

  private String mDstip;

  private int mSrcport = 0;

  private int mDstport = 0;

  private String mType;

  private String mHostname;

  /*

  Constructor

  */

  public SecurityEvent(String hostname,

    String dstip,

    String srcip,

    int dstport,

    int srcport,

    String type)

  {

  mSrcip = srcip;

  mDstip = dstip;

  mHostname = hostname;

  mDstport = dstport;

  mSrcport = srcport;

  mType = type;

  }

  /* member data getters */

   public String getType()

  {

   return mType;

  }

   public String getHostname()

  {

   return mHostname;

  }

   public String getSrcip()

  {

   return mSrcip;

  }

   public String getDstip()

  {

   return mDstip;

  }

   public int getDstport()

  {

   return mDstport;

  }

   public int getSrcport()

  {

   return mSrcport;

  }

 }
