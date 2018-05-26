import java.util.*;

public class Main {
  public static void main(String[] args) {
    Scanner sc = new Scanner(System.in);
    int n = sc.nextInt();
    int[] a = new int[n];
    for(int i = 0; i < n; i++) {
      a[i] = sc.nextInt();
    }

    int ans = 60;

    for(int i = 0; i < n; i++) {
      int x = 0;
      while(a[i] % 2 == 0) {
        a[i] /= 2;
        x++;
      }
      if(ans > x) {
        ans = x;
      }
    }

    System.out.println(ans);

    sc.close();
  }

}
