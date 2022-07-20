function CCLSGenerateCppFunction()
    if !filereadable(".ccls")
        call writefile(["clang", "%h -x", "%h c++-header", "%cpp -std=c++20"], ".ccls", "a")
        echo ".ccls created"
    else
        echo ".ccls already exists"
    endif
endfunction

command CCLSGenerateCpp call CCLSGenerateCppFunction()


