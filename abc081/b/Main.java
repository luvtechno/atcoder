import java.util.*;

public class Main {
  public static void main(String[] args) {
    Scanner sc = new Scanner(System.in);
    int n = sc.nextInt();
    int[] a = new int[n];
    for(int i = 0; i < n; i++) {
      a[i] = sc.nextInt();
    }

    int ans = 0;

    while(true) {
      boolean fail = false;
      for(int i = 0; i < n; i++) {
        if(a[i] % 2 == 0) {
          a[i] /= 2;
        }
        else {
          fail = true;
          break;
        }
      }
      if(fail) break;

      ans++;
    }

    System.out.println(ans);

    sc.close();
  }

}
