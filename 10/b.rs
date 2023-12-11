use std::{io, io::prelude::*, collections};

const dir: [(i32,i32); 4] = [(1,0), (0,1), (-1,0), (0,-1)];

fn main() {
  let map: Vec<Vec<char>> = io::stdin().lock().lines().map(|x| x.unwrap().chars().collect()).collect();
  let width = map[0].len();
  let height = map.len();
  
  let mut moves = collections::HashMap::new();
  
  moves.insert('|', [-1,1,-1,3]);
  moves.insert('-', [0,-1,2,-1]);
  moves.insert('L', [-1,0,3,-1]);
  moves.insert('J', [3,2,-1,-1]);
  moves.insert('7', [1,-1,-1,2]);
  moves.insert('F', [-1,-1,1,0]);
  moves.insert('.', [-1,-1,-1,-1]);
  moves.insert('S', [-1,-1,-1,-1]);
  
  let mut start: (i32,i32) = (0,0);
  
  for y in 0..height {
    for x in 0..width {
      if map[y][x] == 'S' {
        start = (x as i32,y as i32);
      }
    }
  }
  
  let mut startdir: i32 = 0;
  
  for d in 0..4 {
    let newx = start.0 + dir[d].0;
    let newy = start.1 + dir[d].1;
    
    if moves[&map[newy as usize][newx as usize]][d] != -1 {
      startdir = d as i32;
      break;
    }
  }
  
  let mut expand = collections::HashMap::new();
  
  expand.insert('|', [0,1,0,0,1,0,0,1,0]);
  expand.insert('-', [0,0,0,1,1,1,0,0,0]);
  expand.insert('L', [0,1,0,0,1,1,0,0,0]);
  expand.insert('J', [0,1,0,1,1,0,0,0,0]);
  expand.insert('7', [0,0,0,1,1,0,0,1,0]);
  expand.insert('F', [0,0,0,0,1,1,0,1,0]);
  expand.insert('.', [0,0,0,0,0,0,0,0,0]);
  expand.insert('S', [0,1,0,1,1,1,0,1,0]);
  
  let mut fillmap = vec![vec![0;width*3]; height*3];
  
  let mut pos = start;
  let mut length = 0;
  let mut d = startdir;
  
  loop {
    let newx = pos.0 + dir[d as usize].0;
    let newy = pos.1 + dir[d as usize].1;
    
    let tile = &map[newy as usize][newx as usize];
    d = moves[tile][d as usize];
    
    length = length + 1;
    
    pos = (newx,newy);
    
    for x in 0..3 {
      for y in 0..3 {
        fillmap[(pos.1 * 3 + y) as usize][(pos.0 * 3 + x) as usize] = expand[tile][(x + y * 3) as usize];
      }
    }
    
    if map[pos.1 as usize][pos.0 as usize] == 'S' {
      break;
    }
  }
  
  let fw = width*3;
  let fh = height*3;
  
  let mut flood = collections::LinkedList::new();
  
  flood.push_back((0,0));
  
  while !flood.is_empty() {
    let pos = flood.pop_front().unwrap();
    
    if pos.0 > 0 && fillmap[pos.1][pos.0-1] == 0 {
      fillmap[pos.1][pos.0-1] = 2;
      flood.push_back((pos.0-1,pos.1));
    }
    
    if pos.0 < fw-1 && fillmap[pos.1][pos.0+1] == 0 {
      fillmap[pos.1][pos.0+1] = 2;
      flood.push_back((pos.0+1,pos.1));
    }
    
    if pos.1 > 0 && fillmap[pos.1-1][pos.0] == 0 {
      fillmap[pos.1-1][pos.0] = 2;
      flood.push_back((pos.0,pos.1-1));
    }
    
    if pos.1 < fh-1 && fillmap[pos.1+1][pos.0] == 0 {
      fillmap[pos.1+1][pos.0] = 2;
      flood.push_back((pos.0,pos.1+1));
    }
  }
  
  let mut inside = 0;
  
  for y in 0..height {
    for x in 0..width {
      let mut outside = false;
      
      for fy in 0..3 {
        for fx in 0..3 {
          if fillmap[y*3+fy][x*3+fx] == 2 {
            outside = true;
          }
        }
      }
      
      if !outside {
        inside = inside + 1
      }
    }
  }
  
  println!("{}", inside);
}
