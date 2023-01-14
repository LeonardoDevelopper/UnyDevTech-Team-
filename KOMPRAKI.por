programa
{
	inclua biblioteca Util --> ut
	inclua biblioteca Calendario --> cl

	cadeia id_produto[10], id_aux
	cadeia nome_produto[10], nome_aux = ""
	cadeia categoria_produto[10], cat_aux = ""
	cadeia descricao_produto[10], desc_aux = ""
	cadeia data_entrada[10]
	cadeia carrinho[10]
	cadeia produtos_mesma_categoria[10]
	cadeia procurar_produto 
	cadeia nome = "" 
	cadeia palavra_pass = ""
	cadeia pp_aux= ""
	cadeia confirmar
	cadeia id
	cadeia nomep = ""
	cadeia sair = "" 
	cadeia resposta_usuario1 = ""
	
	caracter resposta_usuario = '0'
	
	inteiro quantidade_produto[10], quant_aux = 0
	inteiro preco_produto[10], prec_aux = 0
	inteiro quantidade_produtos = 0
	inteiro itens_carrinho = 0
	inteiro i = 0
	inteiro contar = 0 
	inteiro c = 1
	inteiro aux
	inteiro s = 1
	inteiro carr = 0
	
	logico editando = falso
	logico logado = falso
	logico logado_vendedor = falso
	logico logado_cliente = falso
	logico logado_visitaV = falso
	logico logado_visitaC = falso 
	
	funcao menu(){
		limpa()
		escreva("BemVindo ao KOMPRAKI\n\n")
		escreva("Como deseja prossegiur?\n")
		escreva("1- Criar uma conta/ Iniciar sessão\n")
		escreva("2- Visitar")
		leia(resposta_usuario)
		limpa()
		escolha(resposta_usuario){
			caso '1':
				criar_entrar()
			pare
			caso '2':
				escreva("1-Entrar como cliente\n")
				escreva("2-Entrar como vendedor ")
				leia(resposta_usuario)
				escolha (resposta_usuario){
					caso '1':
						menu_cliente()
						logado_visitaC = verdadeiro
					pare
					caso '2':
						menu_vendedor()
						logado_visitaV = verdadeiro
					pare
				}
				
			pare
		}
		
	}
	funcao comprar_produto(){
		limpa()
		escreva("\nComprar Produto\n\n  ")
		listar_produtos()
		escreva("\n\nSelecione o produto digitando o nome: ")
		nome_aux = ler_nome_produto(nomep)
		limpa()
		se(quantidade_produtos > 0){
			para(inteiro i = 0; i < quantidade_produtos; i++){
				se(nome_aux == nome_produto[i]){
					aux = i
				}	
			}
			se(nome_aux == nome_produto[aux]){
				escreva("\n\n1- para comprar produto\n")
				escreva("2- para adicionar ao carrinho")
				leia(resposta_usuario)
				limpa()
				escolha (resposta_usuario){
					caso '1':
						escreva("Produto compra com sucesso!")	
					pare
					caso '2':
						add_carrinho(nome_aux)
					pare
				}
			}senao{
				escreva("este produto não existe!")
			}
		}senao{
			escreva("Impossivel efectuar compra!")
		}	
		
	}
	funcao Carrinho(){
		limpa()
		escreva("Carrinho\n\n")
		se(itens_carrinho > 0)
		{
			inteiro cont = 1
			escreva("1-Produtos no carrinho")
			escreva("\n2- Adicionar ao carrinho")
			escreva("\n3- remover do carrinho")
			leia(resposta_usuario)
			limpa()
			escolha (resposta_usuario){
				caso '1':
					escreva("\n    Nome     |")
					para(inteiro i = 0; i < itens_carrinho; i++){
						escreva("\n"+cont+" "+carrinho[i])
						cont++
					}
				pare
				caso '2':
					comprar_produto()
				pare
				caso '3':
					
					se(encontrar_nome_produto(ler_nome_produto(nome_aux), carrinho)){
						carrinho[aux] = ""
						para(inteiro a = 0; a < itens_carrinho; a++){
							carrinho[a] = carrinho[a+1]
						}
						cont--
						itens_carrinho--
						limpa()
						escreva("Produto eliminado do carrinho!")
							
					}senao{
						limpa()
						escreva("produto não encontrado")
					}
					
				pare
			}
			
		}senao{
			escreva("O carrinho está vazio!")
		}
		
	}
	funcao add_carrinho(cadeia string){
		carrinho[carr] = string
		carr++
		itens_carrinho++
		escreva("produto adicionado ao carrinho!")
	}
	funcao menu_cliente(){
		limpa()
		se(logado){
			escreva("\nBemvindo ao KOMPRAKI, "+nome)
		}senao{
			escreva("\nBemvindo ao KOMPRAKI ")	
		}
		escreva("\nSiga as instruções abaixo para executar a tarefa")
		escreva("\n1- Comprar")
		escreva("\n2- Carrinho")
		escreva("\n3- Destaques\n")
		escreva("4- Pesquisar produto\n")
		escreva("5- Informações da Conta\n")
		escreva("6- Sair da conta\n")
		escreva("7- Relatar algum problema\n")
		escreva("8- Sair da Loja\n")
		leia(resposta_usuario)
		escolha (resposta_usuario)
		{
			caso '1':
				se(logado){
					comprar_produto()
					voltar_menu_principal()
				}senao{
					ir_criar()
				}
			pare
			caso '2':
				se(logado){
					Carrinho()
					voltar_menu_principal()
				}senao{
					ir_criar()
				}
			pare
			caso '3':
				destaque()
				voltar_menu_principal()
			pare
			caso '4':
				pesquisar()
			pare
			caso '5':
				informacoes_conta()
				voltar_menu_principal()
			pare
			caso '6':
				sair_conta()
				voltar_menu_principal()
			pare
			caso '7':
				relatar_problema()
				voltar_menu_principal()
			pare
			caso '8':
				encerrar()
			pare
		}
	}
	funcao destaque(){
		limpa()
		se(quantidade_produtos > 0){
			escreva("Destaque do dia\n\n")
			i = ut.sorteia(0, quantidade_produtos-1)
			
			escreva("\n"+descricao_produto[i])
			escreva("\n"+nome_produto[i])
			escreva("\n\n\n1- Comprar")
			escreva("\n2- Adicionar ao Carrinho")
			escreva("\n3- Voltar")
			leia(resposta_usuario)
			escolha (resposta_usuario){
				caso '1':
					limpa()
					escreva("Produto comprado com sucesso!")
				pare
				caso '2':
					limpa()
					add_carrinho(nome_produto[i])
					escreva("Produto adicionado ao carrinho")
				pare
				caso '3':
					limpa()
					voltar_menu_principal()
				pare
			}
		}senao{
			escreva("Nenhum produto encontrado!")
		}
		
		
		
	}
	funcao menu_vendedor(){
		limpa()
		se(logado){
			escreva("\nBemvindo ao KOMPRAKI, "+nome)
		}senao{
			escreva("\nBemvindo ao KOMPRAKI ")	
		}
		escreva("\nSiga as instruções abaixo para executar a tarefa")
		escreva("\n1- Cadastrar Produto \n")
		escreva("2- Listar Produto \n")
		escreva("3- Detalhes do Produto \n")
		escreva("4- Eliminar Produto \n")
		escreva("5- Editar Produto \n")
		escreva("6- Criar ou entrar\n")
		escreva("7- Informações da Conta\n")
		escreva("8- Sair da conta\n")
		escreva("9- Relatar algum problema\n")
		escreva("0- Sair da Loja\n")
		leia(resposta_usuario1)

		
			//i = 0
				enquanto(i < 10){
					escreva("\nindice: "+i+"\n")
					//menu_vendedor()
					
					se(resposta_usuario1 == "1"){
						cadastrar_produto(i)
						i++
						voltar_menu_principal()
					}
					senao se(resposta_usuario1 == "2")
					{
						i = 10
						listar_produtos()		
						voltar_menu_principal()
					}
					senao se(resposta_usuario1 == "3")
					{
						detalhes_produto()
						voltar_menu_principal()
					}senao se(resposta_usuario1 == "4")
					{
						eliminar_produto()
						voltar_menu_principal()
					}senao se(resposta_usuario1 == "5"){
						Editar_produto()
						voltar_menu_principal()	
					}senao se(resposta_usuario1 == "6"){
						criar_entrar()
						voltar_menu_principal()	
					}senao se(resposta_usuario1 == "7"){
						informacoes_conta()
						voltar_menu_principal()
					}senao se(resposta_usuario1 == "8"){
						sair_conta()
						voltar_menu_principal()
					}senao se (resposta_usuario1 == "9"){
						relatar_problema()
						voltar_menu_principal()
					}senao se(resposta_usuario1 == "0"){
						limpa()
						escreva("\n\nCerteza que pretende sair?")
						escreva("\n 0       |        1")
						escreva("\nNão      |       Sim   ")
						leia(resposta_usuario)
						escolha(resposta_usuario){
							caso '0':
								menu_vendedor()
							pare
							caso '1':
								encerrar()
							pare
						}
						
					}
				}
		
	

	}
	funcao cadeia ler_nome_produto(cadeia nomep){
		nomep = ""
		resposta_usuario = '0'
		escreva("\nDigite o nome: ")
		enquanto(nomep == ""){
			leia(nomep)
			se(nomep == ""){
				limpa()
				escreva("Nome inválido!")
				escreva("\nDigite o nome: ")
			}
		}
		retorne nomep
	}
	funcao ler_categoria_produto(){
		limpa()
		cat_aux = ""
		id_aux = ""
		resposta_usuario = '0'
		escreva("escolha a categoria do produto:  \n\n1- Alimentação. \n2- Vestuario. \n3- Limpeza \n\n")
		
		enquanto(c != 0){
			leia(resposta_usuario)
			se(resposta_usuario == '1' ou resposta_usuario == '2' ou resposta_usuario == '3'){
				escolha (resposta_usuario)	
				{
					caso '1':
						id_aux = "Al"+ ut.sorteia(100, 9999)
						cat_aux = "Alimentação"
						c = 0
					pare
					caso '2':
						id_aux = "Ve"+ ut.sorteia(100, 9999) 
						cat_aux = "Vestuario"
						c = 0
					pare
					caso '3': 
						id_aux = "Lm"+ ut.sorteia(100, 9999)
						cat_aux= "Limpeza"
						c = 0
					pare
						
				}		
			}senao{
				limpa()
					escreva("Categoria não disponível!\n")
					escreva("escolha a categoria do produto:  \n\n1- Alimentação. \n2- Vestuario. \n3- Limpeza \n\n")
				c++	
			}
		}
	}
	funcao ler_descricao_produto(){
		limpa()
		escreva("\nDê uma descrição ao produto: \n\n")
		enquanto(desc_aux == ""){
			leia(desc_aux)
			se(desc_aux == ""){
				limpa()
				escreva("Nenhuma descriçáo foi escrita!")
				escreva("\nDê uma descrição ao produto: \n\n")	
			}
		}
	}
	funcao ler_quantidade_produto(){
		limpa()
		escreva("\nSelecione a quantidade de produtos \n\n")
		enquanto(quant_aux == 0){
			leia(quant_aux)
			se(quant_aux == 0){
				limpa()
				escreva("Voce deve informar a quantidade que vai entrar em stok!")
				escreva("\nDigite a quantidade do produto: \n\n")	
			}
		}
	}
	funcao ler_preco_produto(){
		limpa()
		escreva("\nDigite o preço do produto: \n\n")
		enquanto(prec_aux == 0){
			leia(prec_aux)
			se(prec_aux == 0){
				limpa()
				escreva("Voce deve informar o preço deste produto!")
				escreva("\nDigite o preço do produto: \n\n")	
			}
		}
	}
	funcao procurar_nome(){
		nome_aux = ler_nome_produto(nomep)
			para(inteiro p = 0; p < quantidade_produtos; p++){
				se(nome_aux == nome_produto[p]){
					limpa()
					escreva("Este produto já existe!\n")
					procurar_nome()
				}
			}
	}
	funcao cadastrar_produto(inteiro i){
		limpa()
		se(logado)
		{
			escreva("Cadastrando Produto")
			procurar_nome()
			ler_categoria_produto()
			ler_quantidade_produto()
			ler_preco_produto()	
			ler_descricao_produto()
			se(nome_aux != "" e id_aux !="" e cat_aux != "" e desc_aux != "" e quant_aux != 0 e prec_aux != 0){
				limpa()
				nome_produto[i] = nome_aux
				id_produto[i] = id_aux
				categoria_produto[i] = cat_aux  
				descricao_produto[i] =  desc_aux
				quantidade_produto[i] = quant_aux
				preco_produto[i] = prec_aux
				se(editando){
					
				}senao{
					data_entrada[i] = cl.dia_mes_atual()+"/"+cl.mes_atual()+"/"+cl.ano_atual()+"|"+cl.hora_atual(falso)+":"+cl.minuto_atual()
					escreva("Cadastrado com sucesso!\n")	
					quantidade_produtos++
				}
				nome_aux = ""
				cat_aux = ""
				id_aux = ""
				desc_aux = ""
				quant_aux = 0
				prec_aux = 0
				c = 1
				resposta_usuario = '0'		
			}senao{
				escreva("Cadastramento incompleto!\n")
			}
		}senao{
			ir_criar()
		}
			
	}
	funcao listar_produtos(){
		limpa()
		se(logado){
			escreva("Produtos disponíveis: \n\n")
			se(quantidade_produtos > 0){
				escreva("   Nome do produto   |     Id do produto   |     Preço do produto    \n\n")
				para(inteiro j = 0; j < quantidade_produtos; j++){
					escreva("       "+nome_produto[j]+"         "+"        "+id_produto[j]+"                    "+preco_produto[j]+",00KZ\n\n\n")			
				}
			}senao{
				escreva("Nenhum Produto cadastrado!")
			}	
		}senao{
			ir_criar()
		}
			
	}
	funcao logico encontrar_nome_produto(cadeia nome, cadeia vetor[]){
		para(inteiro indice = 0; indice < quantidade_produtos; indice++){
				se(nome == vetor[indice]){
					aux = indice
				}
			}
		se(nome == vetor[aux])
		{
			retorne verdadeiro
		}senao{
			retorne falso
		}
			
	}
	funcao logico encontrar_id_produtos(cadeia id, cadeia vetor[]){
		para(inteiro indice = 0; indice < quantidade_produtos; indice++){
				se(id == vetor[indice]){
					aux = indice
				}
			}
		se(id == vetor[aux])
		{
			retorne verdadeiro
		}senao{
			retorne falso
		}
	}
	funcao logico encontrar_categoria_produtos(cadeia categoria, cadeia vetor[]){
		para(inteiro indice = 0; indice < quantidade_produtos; indice++){
				se(categoria == vetor[indice]){
					produtos_mesma_categoria[indice] = nome_produto[indice]
					contar++
				}
			}
		se(contar > 0)
		{
			retorne verdadeiro
		}senao{
			retorne falso
		}
	}
	funcao pesquisar(){
		limpa()
		escreva("Pesquisar Produto\n\n\n")
		escreva("1- Pesquisar por nome\n")
		escreva("2- pesquisar por id\n")
		escreva("3- pesquisar por categoria\n")
		leia(resposta_usuario)
		limpa()
		escolha(resposta_usuario){
			caso '1':
				se(encontrar_nome_produto(ler_nome_produto(nome_aux), nome_produto)){
					escreva("Resultados da pesquisa por nome\n\n")
					escreva("  Nome  \n")
					escreva(" "+nome_produto[aux])
					escreva("1- Comprar\n")
					escreva("2- Adicionar ao carrinho\n")
					escreva("3- voltar")
					leia(resposta_usuario)
					escolha(resposta_usuario){
						caso '1':
							comprar_produto()
						pare
						caso '2':
							add_carrinho(nome_produto[aux])
						pare
						caso '3':
							menu_cliente()
						pare
					}
				}senao{
					limpa()
					escreva("Produto não encontrado!")
				}
			pare
			caso '2':
				/*se(encontrar_nome_produto(ler_id_produto(id_aux, ), id_produto)){
					escreva("Resultados da pesquisa por Id\n\n")
					escreva("  ID  \n")
					escreva(" "+id_produto[aux])
					escreva("1- Comprar\n")
					escreva("2- Adicionar ao carrinho\n")
					escreva("3- voltar")
					leia(resposta_usuario)
					escolha(resposta_usuario){
						caso '1':
							comprar_produto()
						pare
						caso '2':
							add_carrinho(nome_produto[aux])
						pare
						caso '3':
							menu_cliente()
						pare
					}
				}*/
			pare
			caso '3':
				ler_categoria_produto()
				se(encontrar_categoria_produtos(cat_aux, categoria_produto)){
					escreva("Resultados da pesquisa por Categoria\n\n")
					escreva("  Nome  \n")
					para(inteiro items = 0; items < contar; items++){
						escreva("  "+produtos_mesma_categoria[items]+"\n")
					}
					escreva("1- Comprar\n")
					escreva("2- Adicionar ao carrinho\n")
					escreva("3- voltar")
					leia(resposta_usuario)
					escolha(resposta_usuario){
						caso '1':
							comprar_produto()
						pare
						caso '2':
							add_carrinho(nome_produto[aux])
						pare
						caso '3':
							menu_cliente()
						pare
					}
				}senao{
					limpa()
					escreva("Produto não encontrado!")
				}
			pare
			
		}
	}
	funcao detalhes_produto(){
		limpa()
		se(logado){
			escreva("Procurar prooduto: \n\n")
			limpa()	
			se(encontrar_nome_produto(ler_nome_produto(nome_aux), nome_produto)){
				escreva("Detalhes do produto: \n\n\n")
					escreva("   Nome do produto   |     Id do produto    |    Categoria do produto    |       Stok       |       Data          \n")
					escreva("       "+nome_produto[aux]+"         "+"        "+id_produto[aux]+"                    "+categoria_produto[aux]+"                "+quantidade_produto[aux]+"               "+data_entrada[aux])
					escreva("\n\nDescrição:  "+descricao_produto[aux])
					escreva("\n\n\n\n")
			}senao{
				escreva("Produto não encontrado!")
			}	
		}senao{
			ir_criar()	
		}
		
	}
	funcao eliminar_produto(){
		limpa()
		se(logado){
			escreva("\nEliminar produto: \n\n\n")
			escreva("1- Eliminar um produto\n")
			escreva("2- Eliminar todos os produtos")
			leia(resposta_usuario)
			limpa()
			escolha(resposta_usuario){
				caso '1':
					listar_produtos() 
					escreva("Digite o ID do produto: ")
					leia(procurar_produto)
					se(encontrar_id_produtos(procurar_produto, id_produto)){
						quantidade_produtos--
						limpa()
						para(inteiro o = aux; o < quantidade_produtos; o++){
							nome_produto[o] = nome_produto[o+1]	
							id_produto[o] = id_produto[o+1]
							categoria_produto[o] = categoria_produto[o+1]
							descricao_produto[o] = descricao_produto[o+1]
							quantidade_produto[o] = quantidade_produto[o+1]
							preco_produto[o] = preco_produto[o+1]
						}
						escreva("Produto eliminado com sucesso!\n\n")	
					}senao{
						limpa()
						escreva("Produto não encontrado!\n\n")
					}
				pare
				caso '2':
					escreva("\n\nCerteza que pretende eliminar todos os produtos?")
					escreva("\n 0       |        1")
					escreva("\nNão      |       Sim   ")
					leia(resposta_usuario)
					escolha(resposta_usuario){
						caso '0':
							eliminar_produto()
						pare
						caso '1':
							se(quantidade_produtos > 0){
								para(inteiro s = 0; s< quantidade_produtos; s++){
									quantidade_produtos = 0
									id_produto[s] = ""
									nome_produto[s] = ""
									categoria_produto[s] = ""
									descricao_produto[s] = ""
									quantidade_produto[s] = 0
									preco_produto[s] = 0
								}
								escreva("Todos os produtos eliminados com sucesso!")	
							}senao{
								escreva("Nenhum produto encontrado!")
							}
						pare
					}
			}	
		}senao{
			ir_criar()
		}
		
	}
	funcao Editar_produto(){		
		limpa()
		se(logado)
		{
			listar_produtos()
			editando = verdadeiro
			escreva("\n\nEditar produto: \n\n\n")
			escreva("Digite o ID do produto: ")
			leia(procurar_produto)
			limpa()
			se(encontrar_id_produtos(procurar_produto, id_produto)){
					nome_aux = ""
					cat_aux = ""
					id_aux = ""
					desc_aux = ""
					quant_aux = 0
					prec_aux = 0
					escreva("Produto encontrado!\n")
					escreva("\n1- Editar Nome\n2- Editar Categoria\n3- Editar Quantidade\n4- Editar preço\n5- Editar descrição\n6- Editar Tudo")
					leia(resposta_usuario)
					limpa()
					escolha(resposta_usuario)
					{
						caso '1':  
							procurar_nome()
							nome_produto[aux] = nome_aux
							limpa()
							escreva("Nome alterado com sucesso")
						pare
						caso '2': 
							ler_categoria_produto()
							se(id_aux != "" e cat_aux != ""){
									id_produto[aux] = id_aux
									categoria_produto[aux] = cat_aux  
									limpa()
									escreva("Categoria editada com sucesso!")
								}senao{
									limpa()
										escreva("Categoria não disponível!\n")
										escreva("escolha a categoria do produto:  \n\n1- Alimentação. \n2- Vestuario. \n3- Limpeza \n\n")
									c++	
								}
						pare
						caso '3':
							ler_quantidade_produto()
							quantidade_produto[aux] = quant_aux
							limpa()
							escreva("Quantidade do produto editado com sucesso!")
						pare
						caso '4':
							ler_preco_produto()
							preco_produto[aux] = prec_aux
							limpa()
							escreva("Preço do produto editado com sucesso!")
						pare
						caso '5': 		
							ler_descricao_produto()
							descricao_produto[aux] = desc_aux
							limpa()
							escreva("Descricao editado com sucesso!")
						pare
						caso '6': 
							i = aux
							c = 1
							cadastrar_produto(i)
							escreva("Produto alterado com sucesso!\n\n")	
						pare
					}
				}senao{
					limpa()
					escreva("Produto não encontrado!")
				}
				
			editando = falso		
		}senao{
			ir_criar()
		}
		
	}
	funcao criar_entrar(){

		
		limpa()

		escreva("1- Entrar\n")
		escreva("2- Criar\n")
		leia(resposta_usuario)
		limpa()
		escolha(resposta_usuario){
			caso '1':
				escreva("Entrar na sua conta\n\n")
				nome_aux = ler_nome_produto(nomep)
				escreva("\nDigite sua senha: ")
				leia(pp_aux)
				se(nome_aux == nome e pp_aux == palavra_pass){
					escreva("Bem-Vindo, "+nome)
					logado = verdadeiro
				}senao{
					limpa()
					ir_criar()
				}
			pare
			caso '2':
				escreva("Bem vindo ao KOMPRAKI, siga os procedimentos para criar sua conta KOMPRAKI\n\n")
				escreva("Etapa 1 de 4\n\n")
				nome = ler_nome_produto(nomep)
				limpa()
				escreva("Etapa 2 de 4\n\n")
				escreva("Pretende usar este software como: ")
				escreva("\n1- Vendedor\n")
				escreva("2- Cliente  ")
				leia(resposta_usuario)
				limpa()
				escolha (resposta_usuario){
					caso '1':
						id = "1:"+ut.sorteia(0, 10)+":"+ut.sorteia(0, 100)+":"+ut.sorteia(0, 100)+":"+ut.sorteia(0, 100)+"::"+ut.sorteia(0, 100)
						logado_vendedor = verdadeiro
					pare
					caso '2':
						id = "2:"+ut.sorteia(0, 100)+":"+ut.sorteia(0, 100)+":"+ut.sorteia(0, 100)+":"+ut.sorteia(0, 100)+"::"+ut.sorteia(0, 100) 
						logado_cliente = verdadeiro
					pare
				}
				enquanto (s != 0){
					escreva("\nEtapa 3 de 4\n\n")
					escreva("\nDigite sua palavra-pass: ")
					leia(palavra_pass)
					limpa()
					escreva("Confirme sua palavra-pass: ")
					leia(confirmar)
					limpa()
					se(palavra_pass == confirmar){
						s = 0
					}senao{
						escreva("\nPalavra-pass incorrecta!")
					}
					
				}
				teste_lagarta()	
			pare
		}
		
	}
	funcao mostrar(){
		limpa()
		escreva("Etapa 4 de 4\n\n")
		escreva("Devido a questões de segurança precisamos testar se não es um boot\n")
		escreva("Nos diz oque estás vendo?\n\n\n")
	}
	funcao teste_lagarta(){
		mostrar()
		s = 0
		enquanto(s < 1){
			mostrar()
			escreva("\n(..)(..)(..)`(o.o)´")
			ut.aguarde(1000)
			limpa()
			mostrar()
			escreva("     (..)")
			escreva("\n  (..)  (..)`(o.o)´")
			ut.aguarde(1000)
			limpa()
			mostrar()
			escreva("\n   (..)(..)(..)`(o.o)´")
			ut.aguarde(1000)
			limpa()
			mostrar()
			escreva("         (..)")
			escreva("\n      (..)  (..)`(o.o)´")
			ut.aguarde(1000)
			limpa()
			mostrar()
			escreva("\n          (..)(..)(..)`(o.o)´")
			ut.aguarde(1000)
			s++
	}
		escreva("\n1- Comboio\n")
		escreva("2- Lagarta\n")
		escreva("3- borbuleta\n")
		escreva("4- repetir animação\n")
		leia(resposta_usuario)
		limpa()
		escolha(resposta_usuario){
			caso '1':
				escreva("Infelizmente não podemos identificar se es um boot ou não. ")
			pare
			caso '2':
				escreva("\n\nParabens,"+nome+" sua conta KOMPRAKI foi criada!")
				logado = verdadeiro	
			pare
			caso '3':
				escreva("Infelizmente não podemos identificar se es um boot ou não. ")
			pare
			caso '4':
				teste_lagarta()
			pare
		}
		
		
	}
	funcao relatar_problema(){ 
		
		limpa()
		escreva("Relatar algum problema.")
		escreva("\n\n\nOla! Somos a UnyDevTech, se selecionaste está opção então o software está apresentando algum defeito inesperado.\nEntão siga as instruções para que o seu feedback chegue ate nós. ")
		escreva("\nJá tem uma conta? criar uma conta nós ajudará a identificar se o defeito está no lado do vendedor ou do cliente")
		escreva("\n1- Já estou logado")
		escreva("\n2- criar uma conta")
		leia(resposta_usuario)
		escolha(resposta_usuario){
			caso '1': 
			se(logado){
				limpa()
				escreva("\ncomplete as etapas para enviar o melhor feedback possivel")
				escreva("\nEtapa 1 de 3\n\n")
				escreva("1- O sistema está muito lento\n")
				escreva("2- Muitos bugs\n")
				escreva("3- Nenhum\n")
				leia(resposta_usuario)
				limpa()
				escreva("\nEtapa 2 de 3\n\n")
				escreva("Escreva uma descrição para o seu problema\n")
				leia(desc_aux)
				limpa()
				escreva("\nEtapa 3 de 3\n\n")
				escreva("Agradecemos o seu feedback, \nReceberemos seu feedback dentro de pouco tempo, seu contributo nos ajudará a corrigir bugs inesperados no sistema.")
			}senao{
				ir_criar()
			}
				
			pare
			caso '2':
				criar_entrar()
				voltar_menu_principal()
			pare
		}
	}
	funcao ir_criar(){
		
		limpa()
		escreva("\nUps... parece que ainda não tem uma conta\n")
				escreva("\nCriar?\n\n")
				escreva("\n 0       |        1")
				escreva("\nNão      |       Sim   ")
				leia(resposta_usuario)
				escolha(resposta_usuario){
					caso '0':
						menu()
					pare
					caso '1':
						criar_entrar()
					pare
				}
	}
	funcao informacoes_conta(){
		se(logado){
			limpa()
			escreva("Informações da conta")
			escreva("\n\nNome: "+nome)
			escreva("\nId: "+id)
			escreva("\nSenha: ********")	
			escreva("\nEstado: Online*")
		}senao{
			ir_criar()
		}
		
	}
	funcao sair_conta(){
		se(logado){
			limpa()
				escreva("\n\nCerteza que pretende sair da sua conta?")
				escreva("\n 0       |        1")
				escreva("\nNão      |       Sim   ")
				leia(resposta_usuario)
				escolha(resposta_usuario){
					caso '0':
						voltar_menu_principal()
					pare
					caso '1':
						logado = falso
						logado_vendedor = falso
						logado_cliente = falso
						menu()
					pare
				}
		}
	}	
	funcao voltar_menu_principal(){
		escreva("\n\n\nClique 0 para voltar ao Menu principal...")
		leia(resposta_usuario)
		se(resposta_usuario == '0'){			
			limpa()
			i = 0 + quantidade_produtos
			se(logado_visitaV ou logado_vendedor)
			{
				menu_vendedor()
			}
			se(logado_visitaC ou logado_cliente ){
				menu_cliente()	
			}
		}
	}
	funcao encerrar(){
		i = 10
		limpa()
	}
	funcao inicio(){
		menu()
		se(logado_visitaV ou logado_vendedor)
		{
			menu_vendedor()
				
		}
		se(logado_visitaC ou logado_cliente ){
			menu_cliente()	
		}
		


	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 16710; 
 * @DOBRAMENTO-CODIGO = [42, 73, 107, 154, 160, 219, 253, 334, 348, 385, 397, 409, 421, 431, 472, 489, 503, 516, 530, 617, 636, 698, 777, 841, 847, 898, 935, 952, 966, 965, 991, 988, 985, 1000, 1004];
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */