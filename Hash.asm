.text
hash_fn:
    # Load the input word from memory
    lw      $t0, 0($a1) 

    # Extract the first byte
    lb      $t0, 0($t0) 

    # Adjust the byte value (assuming ASCII input)
    addi    $t0, $t0, -48 

    # Initialize the Initial Vector (IV)
    addi    $s7, $0, 20 

    # Extract individual bytes from the input word
    srl     $s3, $t0, 24 
    sll     $s2, $t0, 8
    srl     $s2, $s2, 24
    sll     $s1, $t0, 16
    srl     $s1, $s1, 24
    sll     $s0, $t0, 24
    srl     $s0, $s0, 24

    # XOR the first byte with the IV and call the polynomial function
    xor     $a0, $s3, $s7
    jal     fx

    # Process remaining bytes
    xor     $a0, $s2, $v0
    andi    $a0, $a0, 255 
    jal     fx
    xor     $a0, $s1, $v0
    andi    $a0, $a0, 255 
    jal     fx
    xor     $a0, $s0, $v0
    andi    $a0, $a0, 255 
    jal     fx

    # Extract the final 8-bit hash value
    andi    $v0, $v0, 255

    # Store the hash value in memory (optional)
    addi    $t1, $0, 0
    lui     $t1, 4097
    sw      $v0, 0($t1) 

    # Print the hash value (optional)
    addi    $s0, $v0, 0 
    addi    $v0, $0, 10 
    syscall 

fx: 
    # Save the return address on the stack
    addi    $sp, $sp, -4
    sw      $ra, 0($sp)

    # Store the input value in a temporary register
    addi    $s4, $a0, 0

    # Calculate x^2 using repeated addition (multi function)
    addi    $a1, $a0, 0
    jal     multi

    # Calculate 282*x^2
    addi    $a0, $s6, 0 
    addi    $a1, $0, 282
    jal     multi

    # Calculate 282*x^2 + 271
    addi    $v0, $s6, 271

    # Calculate 99*x
    addi    $a0, $s4, 0
    addi    $a1, $0, 99
    jal     multi

    # Calculate 282*x^2 - 99*x + 271
    sub     $v0, $v0, $s6

    # Restore the return address from the stack
    lw      $ra, 0($sp)
    addi    $sp, $sp, 4

    # Return from the function
    jr      $ra

multi:
    # Initialize the product to 0
    addi    $s6, $0, 0

    # Store the multiplicands in temporary registers
    addi    $t1, $a0, 0
    addi    $t2, $a1, 0

    # Set the loop counter
    addi    $t3, $0, 32 
    addi    $t4, $0, 32

loop:
    # Check if the loop counter has reached zero
    beq     $t3, $t4, skip

    # Left shift the multiplicand
    sll     $t1, $t1, 1

    # Right shift the multiplier
    srl     $t2, $t2, 1

skip:
    # Check if the least significant bit of the multiplier is 1
    andi    $t5, $t2, 1 
    addi    $t3, $t3, -1 
    beq     $t5, $0, z 

    # Add the multiplicand to the product if the bit is 1
    add     $s6, $s6, $t1

z:
    # Continue the loop if the counter is not zero
    bne     $t3, $0, loop

    # Return from the function
    jr      $ra
