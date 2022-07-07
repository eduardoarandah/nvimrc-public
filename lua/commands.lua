-------------------------
-- Commands
-------------------------

-- Delete all registers
-- command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

-- Change dir to current path
-- command! ChangeDir :cd %:p:h<CR>

-- Insert filename
-- command! Fname normal i <c-r>=expand('%:t:r')<cr>
-- command! Fnameext normal i <c-r>=expand('%:t')<cr>

