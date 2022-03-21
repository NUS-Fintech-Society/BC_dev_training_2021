use anchor_lang::prelude::*;

declare_id!("Fg6PaFpoGXkYsidMpWTK6W2BeZ7FEfcYkg476zPFsLnS");

#[program]
pub mod prog1 {
    use super::*;

    pub fn initialize(ctx: Context<Initialize>, balance: u64, bump: u8) -> Result<()> {
        ctx.accounts.balance_account.balance = balance;
        Ok(())
    }

    pub fn transfer(ctx: Context<Transfer>, amount: u64, bump: u8) -> Result<()> {
        if ctx.accounts.from_account.balance < amount {
            return Err(error!(CustomError::InsufficientBalance));
        }

        ctx.accounts.from_account.balance -= amount;
        ctx.accounts.to_account.balance += amount;
        Ok(())
    }
}

#[derive(Accounts)]
#[instruction(bump: u8)]
pub struct Initialize<'info> {
    #[account(mut)]
    pub authority: Signer<'info>,

    #[account(init, payer = authority, space = Balance::LEN, seeds = [&authority.key.to_bytes()], bump)]
    pub balance_account: Box<Account<'info, Balance>>,

    pub system_program: Program<'info, System>,
}

#[derive(Accounts)]
#[instruction(bump: u8)]
pub struct Transfer<'info> {
    #[account(mut)]
    pub authority: Signer<'info>,

    #[account(mut, seeds = [&authority.key.to_bytes()], bump)]
    pub from_account: Box<Account<'info, Balance>>,

    #[account(mut)]
    pub to_account: Box<Account<'info, Balance>>,
}

#[account]
pub struct Balance {
    pub balance: u64,
}

impl Balance {
    pub const LEN: usize = 8 + 8;
}

#[error_code]
pub enum CustomError {
    #[msg("Low balance")]
    InsufficientBalance,
}
