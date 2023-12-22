import java.util.*;

public class Mane {
  private static class Point implements Comparable<Point> {
    public long x;
    public long y;
    
    public Point(long x, long y) {
      this.x = x;
      this.y = y;
    }
    
    @Override
    public int compareTo(Point p) {
      if(y == p.y) {
        return x > p.x ? 1 : (x < p.x ? -1 : 0);
      }
      
      return y < p.y ? -1 : 1;
    }
    
    @Override
    public String toString() {
      return "(" + x + "," + y + ")";
    }
  }
  
  private static class Line implements Comparable<Line> {
    public Point start;
    public Point end;
    
    public Line(Point start, Point end) {
      if(start.y <= end.y) {
        this.start = start;
        this.end = end;
      } else {
        this.start = end;
        this.end = start;
      }
    }
    
    @Override
    public int compareTo(Line l) {
      if(start.compareTo(l.start) == 0) {
        return end.compareTo(l.end);
      }
      
      return start.compareTo(l.start);
    }
    
    @Override
    public String toString() {
      return start.toString() + " -> " + end.toString();
    }
  }
  
  private static class XComp implements Comparator<Point> {
    @Override
    public int compare(Point p1, Point p2) {
      return p1.x > p2.x ? 1 : (p1.x < p2.x ? -1 : 0);
    }
  }
  
  public static long intersection(Point a1, Point a2, Point b1, Point b2) {
    return Math.max(0, Math.min(a2.x, b2.x) - Math.max(a1.x, b1.x)) * Math.max(0, Math.min(a2.y, b2.y) - Math.max(a1.y, b1.y));
  }
  
  public static void main(String[] args) {
    Scanner input = new Scanner(System.in);
    TreeSet<Line> lines = new TreeSet<Line>();
    Point position = new Point(0, 0);
    
    while(input.hasNextLine()) {
      String[] dig = input.nextLine().split(" ", 0);
      
      int dir = Integer.parseInt(dig[2].substring(7, 8), 16);
      int dist = Integer.parseInt(dig[2].substring(2, 7), 16);
      
      if(dir == 0) {
        Point newposition = new Point(position.x + dist, position.y);
        lines.add(new Line(position, newposition));
        position = newposition;
      } else if(dir == 2) {
        Point newposition = new Point(position.x - dist, position.y);
        lines.add(new Line(position, newposition));
        position = newposition;
      } else if(dir == 1) {
        Point newposition = new Point(position.x, position.y + dist);
        lines.add(new Line(position, newposition));
        position = newposition;
      } else if(dir == 3) {
        Point newposition = new Point(position.x, position.y - dist);
        lines.add(new Line(position, newposition));
        position = newposition;
      }
    }
    
    long filled = 0;
    ArrayList<Point> xs = new ArrayList<Point>();
    ArrayList<Line> diag = new ArrayList<Line>();
    long y0 = lines.first().start.y;
    Point end = lines.last().end;
    
    lines.add(new Line(new Point(end.x + 1000, end.y+10), new Point(end.x + 1000, end.y+11)));
    
    for(Line line : lines) {
      if(line.start.y > y0) {
        long y1 = line.start.y;
        
        ArrayList<Point> newxs = new ArrayList<Point>();
        ArrayList<Line> newdiag = new ArrayList<Line>();
        
        Collections.sort(xs, new XComp());
        
        for(int i = 0; i < xs.size(); i+=2) {
          Point p1 = xs.get(i);
          Point p2 = xs.get(i+1);
          
          newdiag.add(new Line(new Point(p1.x, y0), new Point(p2.x + 1, y1 + 1)));
          
          filled += (y1 - y0 + 1) * (p2.x - p1.x + 1);
          
          if(p1.y > y1) {
            newxs.add(p1);
          }
          
          if(p2.y > y1) {
            newxs.add(p2);
          }
        }
        
        for(Line d1 : diag) {
          for(Line d2 : newdiag) {
            filled -= intersection(d1.start, d1.end, d2.start, d2.end);
          }
        }
        
        diag = newdiag;
        xs = newxs;
        y0 = y1;
      }
      
      if(line.start.y == line.end.y) {
        continue;
      }
      
      xs.add(line.end);
    }
    
    System.out.println(filled);
  }
}
