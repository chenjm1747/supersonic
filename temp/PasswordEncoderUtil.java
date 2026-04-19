import javax.crypto.Cipher;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;
import java.security.MessageDigest;
import java.security.spec.KeySpec;
import java.util.Base64;

public class PasswordEncoderUtil {
    private static final String ALGORITHM = "AES/CBC/PKCS5Padding";
    private static final String ENCODE = "UTF-8";
    private static final String SECRET_KEY_ALGORITHM = "PBKDF2WithHmacSHA256";
    private static final int ITERATIONS = 65536;
    private static final int KEY_LENGTH = 256;
    private static final String IV = "supersonic@bicom";

    public static byte[] generateSalt(String username) throws Exception {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        md.update(username.getBytes(ENCODE));
        byte[] hash = md.digest();
        byte[] salt = new byte[16];
        System.arraycopy(hash, 0, salt, 0, salt.length);
        return salt;
    }

    public static String encrypt(String password, byte[] salt) throws Exception {
        byte[] iv = IV.getBytes(ENCODE);
        IvParameterSpec ivParameterSpec = new IvParameterSpec(iv);

        KeySpec keySpec = new PBEKeySpec(password.toCharArray(), salt, ITERATIONS, KEY_LENGTH);
        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(SECRET_KEY_ALGORITHM);
        byte[] keyBytes = keyFactory.generateSecret(keySpec).getEncoded();
        SecretKeySpec secretKeySpec = new SecretKeySpec(keyBytes, "AES");

        Cipher cipher = Cipher.getInstance(ALGORITHM);
        cipher.init(Cipher.ENCRYPT_MODE, secretKeySpec, ivParameterSpec);

        byte[] encrypted = cipher.doFinal(password.getBytes(ENCODE));
        byte[] combined = new byte[iv.length + encrypted.length];
        System.arraycopy(iv, 0, combined, 0, iv.length);
        System.arraycopy(encrypted, 0, combined, iv.length, encrypted.length);

        return Base64.getEncoder().encodeToString(combined);
    }

    public static void main(String[] args) throws Exception {
        String password = args.length > 0 ? args[0] : "admin";
        String username = args.length > 1 ? args[1] : "admin";
        
        byte[] salt = generateSalt(username);
        String encryptedPassword = encrypt(password, salt);
        
        System.out.println("Username: " + username);
        System.out.println("Password: " + password);
        System.out.println("Salt: " + Base64.getEncoder().encodeToString(salt));
        System.out.println("Encrypted Password: " + encryptedPassword);
        System.out.println();
        System.out.println("SQL Update:");
        System.out.println("UPDATE heating_analytics.s2_user SET password = '" + encryptedPassword + "', salt = '" + Base64.getEncoder().encodeToString(salt) + "' WHERE name = '" + username + "';");
    }
}
