use anchor_lang::prelude::*;

declare_id!("Fg6PaFpoGXkYsidMpWTK6W2BeZ7FEfcYkg476zPFsLnS");

#[program]
pub mod prog1 {
    use super::*;

    pub fn initialize(ctx: Context<Initialize>, input: Vec<u8>) -> Result<()> {
        ctx.accounts.state_account.content = input;
        Ok(())
    }
}

#[derive(Accounts)]
pub struct Initialize<'info> {
    #[account(mut)]
    pub authority: Signer<'info>,

    #[account(init, payer = authority, space = AccountData::LEN)]
    pub state_account: Box<Account<'info, AccountData>>,
    pub system_program: Program<'info, System>,
}

#[account]
pub struct AccountData {
    pub content: Vec<u8>,
}

impl AccountData {
    pub const LEN: usize = 32;
}
