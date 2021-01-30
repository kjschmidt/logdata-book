import Jess.*;

public class Main {
   public static void main(String[] argv) {
      try {
         //Create new Rete instance
         Rete rete = new Rete();
         //Read in the rules file from file
         rete.executeCommand(“(batch myrules.clp)”);
         //Define our Java SecurityClass as a Jess class called event
         rete.defclass(“event,” “SecurityEvent,” null);
         //Create an new instance of a SecurityEvent and assert it rete.definstance(“event,”
         new SecurityEvent(“webserver,” //hostname
           “10.0.0.2,” //dst ip
           “10.0.0.3,” //src ip
           80, //dst port
           5512, //src port
           “Web-Access-Event” // event type), false);
         // Run the engine
         rete.run();
       } catch(JessException jex) {
          jex.printStackTrace();
       }
    }
 }
