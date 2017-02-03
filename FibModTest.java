/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fibmodtest;
import  java.io.*;
import java.util.Scanner;
import java.lang.Math;
/**
 *
 * @author jcl160030
 */
public class FibModTest {

public static void main(String[] args)
  {
    Scanner in = new Scanner(System.in);
        int f0,f1,f2,m;
        f1 = 1;
        f0 =1;
        f2 = 0;
        System.out.println("Enter a value of m: ");
    m=4;    
    int period =0;
    int power = (int)Math.pow(2,m);
    //m = in.nextInt();
    System.out.print(f0 + " "+f1+" ");
        for(int i=0; i<15; i--)
        {
            if(f0%power == 1 && f1%power == 1 && i!=0)
            {
              System.out.println("THE PERIOD: " + period);
              i = 15;
              break;
            }
            f2 = f1+f0;
            f0 = f1;
            f1 = f2;

//        System.out.print(f2 % power + " ");
          period++ ;
        }
  }
}
