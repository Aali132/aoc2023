use std::{io, io::prelude::*, collections};

const dir: [(i32,i32); 4] = [(1,0), (0,1), (-1,0), (0,-1)];

fn main() {
  let map: Vec<Vec<char>> = io::stdin().lock().lines().map(|x| x.unwrap().chars().collect()).collect();
  
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
  
  for y in 0..map.len() {
    for x in 0..map[0].len() {
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
  
  let mut pos = start;
  let mut length = 0;
  let mut d = startdir;
  
  loop {
    let newx = pos.0 + dir[d as usize].0;
    let newy = pos.1 + dir[d as usize].1;
    
    d = moves[&map[newy as usize][newx as usize]][d as usize];
    
    length = length + 1;
    
    pos = (newx,newy);
    
    if map[pos.1 as usize][pos.0 as usize] == 'S' {
      break;
    }
  }
  
  println!("{}", length/2);
}
