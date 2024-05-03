package res;

import java.util.Properties;
import java.util.Random;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.entity.User;



public class SendEmail {

    public String getRandom() {
        Random random = new Random();
        int number = random.nextInt(999999);
        return String.format("%06d", number);
    }

    public boolean sendEmail(User user) {
        boolean test = false;

        String toEmail = user.getEmail();
        final String fromEmail = "momensaifi19@gmail.com";
        final String password = "dicm pzwy uhmy qhae";

        try {
            Properties pr = new Properties();
            pr.put("mail.smtp.host", "smtp.gmail.com");
            pr.put("mail.smtp.port", "587");
            pr.put("mail.smtp.auth", "true");
            pr.put("mail.smtp.starttls.enable", "true");

            // get Session
            Session session = Session.getInstance(pr, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(fromEmail, password);
                }
            });

            MimeMessage msg = new MimeMessage(session);

            msg.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            msg.setFrom(new InternetAddress(fromEmail));
            msg.setSubject("User Email Verification");
            msg.setText("Registration successful. Please verify your account using this code: " + user.getCode());

            Transport.send(msg);
            test = true;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return test;
    }
}
