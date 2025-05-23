// Script para modo quiosque (tela cheia)
document.addEventListener('DOMContentLoaded', function() {
    // Função para entrar em modo de tela cheia
    function enterFullscreen() {
        const element = document.documentElement;
        
        if (element.requestFullscreen) {
            element.requestFullscreen();
        } else if (element.mozRequestFullScreen) { // Firefox
            element.mozRequestFullScreen();
        } else if (element.webkitRequestFullscreen) { // Chrome, Safari e Opera
            element.webkitRequestFullscreen();
        } else if (element.msRequestFullscreen) { // IE/Edge
            element.msRequestFullscreen();
        }
    }
    
    // Tenta entrar em modo de tela cheia ao carregar a página
    // Isso só funcionará se for acionado por um evento de usuário (como um clique)
    // Então criamos um botão temporário que irá disparar o modo de tela cheia
    const fullscreenButton = document.createElement('button');
    fullscreenButton.textContent = 'Entrar em Modo Quiosque';
    fullscreenButton.style.position = 'fixed';
    fullscreenButton.style.top = '10px';
    fullscreenButton.style.right = '10px';
    fullscreenButton.style.zIndex = '1000';
    fullscreenButton.style.padding = '10px';
    fullscreenButton.style.backgroundColor = '#0056b3';
    fullscreenButton.style.color = 'white';
    fullscreenButton.style.border = 'none';
    fullscreenButton.style.borderRadius = '4px';
    fullscreenButton.style.cursor = 'pointer';
    
    document.body.appendChild(fullscreenButton);
    
    fullscreenButton.addEventListener('click', function() {
        enterFullscreen();
        // Remover o botão após entrar em tela cheia
        setTimeout(() => {
            this.remove();
        }, 1000);
    });
    
    // Prevenção de saída acidental da tela cheia
    document.addEventListener('keydown', function(e) {
        // Prevenir a tecla Esc de sair do modo tela cheia
        if (e.key === 'Escape' || e.keyCode === 27) {
            e.preventDefault();
            return false;
        }
    });
    
    // Máscara para o campo de telefone
    const telefoneInput = document.getElementById('telefone');
    if (telefoneInput) {
        telefoneInput.addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value.length > 0) {
                // Formato: (00) 00000-0000
                if (value.length <= 2) {
                    value = `(${value}`;
                } else if (value.length <= 7) {
                    value = `(${value.substring(0, 2)}) ${value.substring(2)}`;
                } else if (value.length <= 11) {
                    value = `(${value.substring(0, 2)}) ${value.substring(2, 7)}-${value.substring(7)}`;
                } else {
                    value = `(${value.substring(0, 2)}) ${value.substring(2, 7)}-${value.substring(7, 11)}`;
                }
            }
            e.target.value = value;
        });
    }
    
    // Validação básica do formulário
    const formularioCliente = document.getElementById('formulario-cliente');
    if (formularioCliente) {
        formularioCliente.addEventListener('submit', function(e) {
            const email = document.getElementById('email').value;
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            
            if (!emailRegex.test(email)) {
                e.preventDefault();
                alert('Por favor, insira um endereço de e-mail válido.');
                return false;
            }
            
            const telefone = document.getElementById('telefone').value;
            if (telefone.replace(/\D/g, '').length < 10) {
                e.preventDefault();
                alert('Por favor, insira um número de telefone válido.');
                return false;
            }
        });
    }
}); 