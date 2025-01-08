# MIPS Assembly Implementation of a Unique 8-bit Hashing Algorithm

**Objective**

successfully implemented a unique 8-bit hashing algorithm in MIPS assembly language using the MARS IDE. The project aimed to provide hands-on experience with MIPS assembly programming concepts while demonstrating the application of hashing techniques.

![image](https://github.com/user-attachments/assets/14e0fe84-130f-45c4-a6d1-f1dd39771080)


**Implementation**

The implemented hashing algorithm processes a 32-bit input word by:

1. **Dividing:** The input word into four 8-bit sections.
2. **Processing:** Each byte sequentially:
    * **XORing:** The byte with the result of the previous byte's hashing or the Initial Vector (IV) for the first byte.
     * **Substituting:** The XOR result using a polynomial transformation function (F): 
        * **F(x) = 282x² - 99x + 271**

**Key Features**

* **MIPS Assembly:** The project is entirely implemented in MIPS assembly language using only the most basic instructions. To achieve multiplication, I implemented it using repeated addition, avoiding the use of more advanced multiplication instructions.
* **MARS IDE:** The program is developed and tested within the MARS (MIPS Assembler and Runtime Simulator) environment.
* **Custom Hashing Algorithm:** The implemented algorithm is unique and incorporates a combination of XOR operations and polynomial substitution.
* **Efficient Implementation:** The code is optimized for performance and readability within the MIPS assembly context.

**Testing and Results**

The implemented hashing algorithm has been thoroughly tested with various input values. The program consistently produces the correct 8-bit hash values as per the defined algorithm. 

**Conclusion**

This project successfully demonstrates a practical application of MIPS assembly programming by implementing a custom 8-bit hashing algorithm. The project provides valuable insights into assembly language programming techniques and the principles of hashing algorithms.

**Improvements**

* **Performance Optimization:** Explore further optimization techniques within the MIPS assembly environment to enhance the program's execution speed.
* **Error Handling:** Implement robust error handling mechanisms to gracefully handle invalid input values or unexpected conditions.
* **Integration:** Investigate potential integrations with other software systems or applications that could benefit from the implemented hashing algorithm.
