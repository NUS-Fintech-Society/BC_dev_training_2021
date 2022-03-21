use std::fmt::Debug;

#[derive(Debug)]
pub struct TokenBalance {
    pub balance: u64,
    pub is_admin: bool,
}

impl TokenBalance {
    pub fn new() -> Self {
        TokenBalance {
            balance: 0,
            is_admin: false,
        }
    }
}

pub struct Containter<T> {
    item: T,
}

impl<T> Containter<T> {
    pub fn new(item: T) -> Containter<T> {
        Self { item }
    }
}

impl<T: Debug> Containter<T> {
    pub fn print(self) {
        println!("{:?}", self.item);
    }
}
