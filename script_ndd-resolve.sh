#!/bin/bash
#BY: DANIELSON


# Cores
vermelho='\033[0;31m'
verde='\033[0;32m'
amarelo='\033[0;44m'
reset='\033[0m'

menu_opcoes(){
clear

opcao=false

while ! $opcao; do
    echo "############################################################################################"
    echo -e "#           ${amarelo}NDD RESOLVE - PROGRAMA PARA RESOLVER PROBLEMAS DE NDD DO PDV${reset}                   #"                               
    echo "# Primeiramente, execute o Metodo Basico(1), se não resolver, execute o Metodo Completo(2) #"
    echo "# 1-Metodo Basico                                                                          #"                                                                       
    echo "# 2-Metodo Completo                                                                        #"
    echo "# 3-Ver status do NDD                                                                      #"
    echo "# 4-Sair                                                                                   #"
    echo "############################################################################################"
    read -p "Digite uma opcao (1, 2 ou 3): " opcao

    case $opcao in
        1)
            opcao=true
            ndd-basico
            ;;
        2)
            opcao=true
            ndd-completo
            ;;

        3)
            opcao=true
            ver_status_ndd
            ;;

        4)
            opcao=true
            echo "Saindo do Programa..."
            break
            ;;    
        *)
            echo "Opção inválida. Digite (1, 2 ou 3)."
            ;;
    esac
done


}

rever_menu (){

    opcao=0

    while true; do
        read -p "Deseja voltar para o menu de opções? (1-Sim 2-Não): " opcao
        
        case $opcao in
            1)
                echo "Voltando para o menu de opções..."
                menu_opcoes
                break ;;  # Sai do loop
            2)
                echo "Encerrando o programa..."
                exit ;;  # Encerra o programa
            *)
                echo "Opção inválida. Por favor, escolha 1 (Sim) ou 2 (Não)." ;;
        esac
    done

}

remove_config() {
    # Navegue até o diretório '/usr/local/nddigital/agent'
    cd /usr/local/nddigital/agent

    # Parar o serviço 'nddigital-agent'
    sudo service nddigital-agent stop

    # Remover os diretórios 'in/', 'logs/' e 'control'
    sudo rm -rf in/ logs/ control

    # Navegar até o diretório '/usr/local/nddigital/agent/config'
    cd /usr/local/nddigital/agent/config

    # Remover os arquivos 'configconvertdata.*'
    sudo rm configconvertdata.*

    # Remover os arquivos 'configimpressiondata.*'
    sudo rm configimpressiondata.*

    # Remover o arquivo 'config.properties'
    sudo rm config.properties
}

# Iniciar o serviço 'nddigital-agent'
start_ndd (){
    sudo service nddigital-agent start
}

ver_status_ndd (){
    echo -e "${amarelo}##### STATUS DO NDD #####${reset}"
    cat /usr/local/nddigital/agent/control/status/ARM* | head -n 5 | tail -n 1
    rever_menu
}

ndd-basico(){
    # Navegue até o diretório '/usr/local/nddigital/agent'
    cd /usr/local/nddigital/agent/config

    # Parar o serviço 'nddigital-agent'
    sudo service nddigital-agent stop

    # Remover o arquivo 'config.properties'
    sudo rm config.properties

    echo -e "${amarelo}##### O SCRIPT (METODO 1) FOI EXECUTADO COM SUCESSO #####${reset}"
    
    rever_menu

}

ndd-completo(){

    valid_uf=false

    while ! $valid_uf; do
        read -p "Digite a UF da loja em caixa alta (MA, PI, CE, BA, PE, PA, TO): " uf

        case $uf in
            MA)
                valid_uf=true
                remove_config
                sudo cp /u1/dbacaixa/cupom-ndd/ndd/config.properties.MA .
                sudo mv config.properties.MA config.properties
                sudo chmod 644 config.properties
                start_ndd
                ;;
            PI)
                valid_uf=true
                remove_config
                sudo cp /u1/dbacaixa/cupom-ndd/ndd/config.properties.PI .
                sudo mv config.properties.PI config.properties
                sudo chmod 644 config.properties
                start_ndd
                ;;
            CE)
                valid_uf=true
                remove_config
                sudo cp /u1/dbacaixa/cupom-ndd/ndd/config.properties.CE .
                sudo mv config.properties.CE config.properties
                sudo chmod 644 config.properties
                start_ndd
                ;;
            PE)
                valid_uf=true
                remove_config
                sudo cp /u1/dbacaixa/cupom-ndd/ndd/config.properties.PE .
                sudo mv config.properties.PE config.properties
                sudo chmod 644 config.properties
                start_ndd
                ;; 
            TO)
                valid_uf=true
                remove_config
                sudo cp /u1/dbacaixa/cupom-ndd/ndd/config.properties.TO .
                sudo mv config.properties.TO config.properties
                sudo chmod 644 config.properties
                start_ndd
                ;;
            PA)
                valid_uf=true
                remove_config
                sudo cp /u1/dbacaixa/cupom-ndd/ndd/config.properties.PA .
                sudo mv config.properties.PA config.properties
                sudo chmod 644 config.properties
                start_ndd
                ;;
            BA)
                valid_uf=true
                remove_config
                sudo cp /u1/dbacaixa/cupom-ndd/ndd/config.properties.BA .
                sudo mv config.properties.BA config.properties
                sudo chmod 644 config.properties
                start_ndd
                ;;    

            *)
                echo "Opção inválida. Digite um dos estados a seguir (MA, PI, CE, BA, PE, PA, TO)."
                ;;
        esac
    done

    echo -e "${amarelo}##### O SCRIPT (METODO 2) FOI EXECUTADO COM SUCESSO #####${reset}"
    rever_menu

}

#Chamada do Menu de Opções
menu_opcoes



