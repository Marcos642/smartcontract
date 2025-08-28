// SPDX-License-Identifier: MIT
// Identifica a licença do contrato (MIT é uma licença de uso aberta)
pragma solidity ^0.8.0; 
// Define a versão do compilador Solidity (aqui: >= 0.8.0)

// Início do contrato
contract SoftwareLicense {
    address public owner; // Dono do contrato (quem criou o software)
    uint public licensePrice = 1 ether; // Preço da licença (aqui, 1 Ether)
    uint public licenseDuration = 30 days; // Duração da licença (30 dias)

    // Armazena a validade da licença de cada usuário
    mapping(address => uint) public licenses;

    // Construtor: executa quando o contrato é criado
    constructor() {
        owner = msg.sender; // Define que o dono é quem criou o contrato
    }

    // Função para comprar a licença
    function buyLicense() public payable {
        // Verifica se o valor pago é exatamente o preço da licença
        require(msg.value == licensePrice, "Valor incorreto.");
        // Registra a data de expiração da licença (data atual + duração)
        licenses[msg.sender] = block.timestamp + licenseDuration;
    }

    // Função para verificar se um usuário ainda tem licença válida
    function checkLicense(address user) public view returns (bool) {
        // Retorna true se o prazo de validade for maior que o tempo atual
        return licenses[user] > block.timestamp;
    }

    // Função para o dono retirar o dinheiro acumulado no contrato
    function withdraw() public {
        // Só o dono pode sacar
        require(msg.sender == owner, "Apenas o dono pode sacar.");
        // Transfere o saldo do contrato para o dono
        payable(owner).transfer(address(this).balance);
    }
}
