import java.util.*;

public class Mane {
  private static class Point {
    public static int minX = 10000;
    public static int maxX = -10000;
    public static int minY = 10000;
    public static int maxY = -10000;
    
    public int x;
    public int y;
    
    public Point(int x, int y) {
      this.x = x;
      this.y = y;
      
      if(x < minX) {
        minX = x;
      }
      
      if(x > maxX) {
        maxX = x;
      }
      
      if(y < minY) {
        minY = y;
      }
      
      if(y > maxY) {
        maxY = y;
      }
    }
    
    public String toString() {
      return "(" + x + "," + y + ")";
    }
  }
  
  private static class Line {
    public Point start;
    public Point end;
    
    public Line(Point start, Point end) {
      this.start = start;
      this.end = end;
    }
    
    @Override
    public String toString() {
      return start.toString() + " -> " + end.toString();
    }
  }
  
  public static void main(String[] args) {
    Scanner input = new Scanner(System.in);
    ArrayList<Line> lines = new ArrayList<Line>();
    Point position = new Point(0, 0);
    
    while(input.hasNextLine()) {
      String[] dig = input.nextLine().split(" ", 0);
      int dist = Integer.parseInt(dig[1]);
      
      if(dig[0].equals("R")) {
        Point newposition = new Point(position.x + dist, position.y);
        lines.add(new Line(position, newposition));
        position = newposition;
      } else if(dig[0].equals("L")) {
        Point newposition = new Point(position.x - dist, position.y);
        lines.add(new Line(position, newposition));
        position = newposition;
      } else if(dig[0].equals("D")) {
        Point newposition = new Point(position.x, position.y + dist);
        lines.add(new Line(position, newposition));
        position = newposition;
      } else if(dig[0].equals("U")) {
        Point newposition = new Point(position.x, position.y - dist);
        lines.add(new Line(position, newposition));
        position = newposition;
      }
    }
    
    int filled = 0;
    int score = 0;
    
    for(int y = Point.minY; y <= Point.maxY; y++) {
      for(int x = Point.minX; x <= Point.maxX; x++) {
        int on_line = 0;
        
        for(Line line : lines) {
          if(line.start.x == x && line.end.x == x && line.start.y <= y && line.end.y >= y) {
            on_line = 1;
          }
          
          if(line.start.x == x && line.end.x == x && line.start.y >= y && line.end.y <= y) {
            on_line = 2;
          }
          
          if(line.start.y == y && line.end.y == y && line.start.x <= x && line.end.x >= x) {
            on_line = 3;
          }
          
          if(line.start.y == y && line.end.y == y && line.start.x >= x && line.end.x <= x) {
            on_line = 4;
          }
          
          if(line.start.y != line.end.y) {
            if(line.start.y < y && line.end.y >= y) {
              if(line.start.x == x) {
                score++;
              }
            }
            
            if(line.end.y < y && line.start.y >= y) {
              if(line.start.x == x) {
                score--;
              }
            }
          }
        }
        
        if(on_line != 0) {
          filled++;
        } else if(score != 0) {
          filled++;
        }
      }
    }
    
    System.out.println(filled);
  }
}
