fn main() -> Result<(), Box<dyn Error>> {
    // example1();
    // example2();
    // example3();
    // example4();
    // example5();
    // example6();

    example7()?;

    Ok(())
}
fn example1() {
    println!("SOLANAAA!");
}

fn add(x: i8, y: i8) -> i8 {
    // return x + y;
    x + y
}

fn example2() {
    let x = 3;
    let y: i8 = 6;
    println!("{}", add(x, y));

    let mut z = 5;
    z -= 5;

    println!("{}", z);
}

fn example3() {
    let _x = "&str";
    let mut y = "String".to_string();

    y += "y";

    for i in 1..5 {
        println!("{}: {}", i, y);
    }

    let v = vec![5, 10, 15, 20];

    let q: Vec<i32> = v.iter().map(|x| x * 10).collect();

    for i in q {
        println!("{:?}", i);
    }
}

fn f1(x: Vec<i32>) {
    println!("{:?}", x);
}

fn f2(x: &Vec<i32>) {
    println!("{:?}", x);
}

fn f3(x: &mut Vec<i32>) {
    x.push(4);
    println!("{:?}", x);
}

fn example4() {
    let x = vec![1, 2, 3];
    f1(x);
    // f1(x);

    let mut y = vec![1, 2, 3];
    f2(&y);
    f3(&mut y);

    for i in y {
        println!("{}", i);
    }
}

mod token;
use token::TokenBalance;

trait Adminize {
    fn make_admin(&mut self);
}

impl Adminize for TokenBalance {
    fn make_admin(&mut self) {
        self.is_admin = true;
    }
}

fn example5() {
    let b = TokenBalance {
        balance: 10,
        is_admin: false,
    };

    println!("{:?}", b);

    let mut c = TokenBalance::new();
    c.make_admin();

    println!("{:?}", c);
}

use token::Containter;

fn example6() {
    let d = Containter::new(1);
    d.print();

    // let e = Containter::new(Containter::new(1));
    // e.print();
}

use std::error::Error;
use std::io::stdin;

fn example7() -> Result<(), Box<dyn Error>> {
    let mut buf = String::new();
    let _r = stdin().read_line(&mut buf);
    buf = buf.trim_end().to_string();

    // match _r {
    //     Ok(v) => {
    //         println!("{:?}", v);
    //     }
    //     Err(v) => {
    //         println!("{:?}", v);
    //     }
    // }
    //
    // Result<i32, ...>
    let i: i32 = buf.parse()?;

    println!("{}", i);

    Ok(())
}
