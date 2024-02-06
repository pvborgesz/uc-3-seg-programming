<?xml-model href="http://www.ncl.org.br/NCL4.0/profiles/NCL40.xsd"?>

<ncl xmlns="http://www.ncl.org.br/NCL4.0/NCL4Profile" id="appNCL">
	<head>

		<transitionBase>
			<transition id="trans1" type="fade" dur="2s"/>
			<transition id="trans2" type="barWipe" dur="1s"/>
			</transitionBase>

		<regionBase>
			<importBase documentURI="regionbase.reg"
				alias="rg" />
		</regionBase>

		<descriptorBase>
			<descriptor id="dsFullScreen" region="rg#rgFullScreen"/>
			<descriptor id="dsInteratividade" region="rg#rgInteratividade" />
			<descriptor id="dsLocalizacao" region="rg#rgLocalizacao" />
			<descriptor id="dsTelaInteracao" region="rg#rgTelaInteracao" />
			<descriptor id="dsCondicoesBtn" region="rg#rgCondicoesBotoes" />
			<descriptor id="dsChannel1" region="rg#rgCondicoesBotoes" />
			<descriptor id="dsChannel2" region="rg#rgCondicoesBotoes" />

			<descriptor id="dsFundo" region="rg#rgFundo" />
			<descriptor id="dsConteudoFundo" region="rg#rgConteudoFundo" />
			<descriptor id="dsConteudoTexto" region="rg#rgConteudoTexto" />
			<descriptor id="dsVideo" region="rg#rgVideo" />
			<descriptor id="dsBackground" region="rg#rgBackground" transIn="trans1"
			transOut="trans2"/>

		</descriptorBase>
		<connectorBase>
			<!-- ################################
	   			#	OnEnd CONNECTORS
	   		################################-->
			<causalConnector id="onEndAttributionTestStopNStartN">
				<connectorParam name="varTest" />
				<compoundCondition operator="and">
					<simpleCondition role="onEndAttribution" />
					<assessmentStatement comparator="eq">
						<attributeAssessment attributeType="nodeProperty" eventType="attribution"
							role="attNodeTest" />
						<valueAssessment value="$varTest" />
					</assessmentStatement>
				</compoundCondition>
				<compoundAction operator="seq">
					<simpleAction max="unbounded" qualifier="par" role="stop" />
					<simpleAction max="unbounded" qualifier="par" role="start" />
				</compoundAction>
			</causalConnector>

			<causalConnector id="onEndStartN">
				<simpleCondition role="onEnd" />
				<simpleAction role="start" max="unbounded" qualifier="seq" />
			</causalConnector>

			<causalConnector id="onEndStopN">
				<simpleCondition role="onEnd" />
				<simpleAction max="unbounded" qualifier="par" role="stop" />
			</causalConnector>

			<causalConnector id="onOrEndTestStartN">
				<compoundCondition operator="and">
					<simpleCondition max="unbounded" delay="0.3s" qualifier="or" role="onEnd" />
					<compoundStatement operator="and">
						<assessmentStatement comparator="eq">
							<attributeAssessment attributeType="nodeProperty"
								eventType="attribution" role="teststartChannel1" />
							<valueAssessment value="false" />
						</assessmentStatement>
						<assessmentStatement comparator="eq">
							<attributeAssessment role="testFullScreen" eventType="attribution"
								attributeType="nodeProperty" />
							<valueAssessment value="true" />
						</assessmentStatement>
					</compoundStatement>
				</compoundCondition>
				<simpleAction max="unbounded" qualifier="seq" role="start" />
			</causalConnector>

			<causalConnector id="onEndTestStartNStopN">
				<compoundCondition operator="and">
					<simpleCondition role="onEnd" />
					<assessmentStatement comparator="eq">
						<attributeAssessment attributeType="nodeProperty" eventType="attribution"
							role="testFullScreen" />
						<valueAssessment value="true" />
					</assessmentStatement>
				</compoundCondition>
				<compoundAction operator="seq">
					<simpleAction max="unbounded" qualifier="par" role="start" />
					<simpleAction max="unbounded" qualifier="par" role="stop" />
				</compoundAction>
			</causalConnector>

			<!-- #######################################
	   #	OnKeySelection CONNECTORS
	   ######################################-->


			<causalConnector id="onKeySelectionStartNSetNStopN">
				<connectorParam name="var" />
				<connectorParam name="keyCode" />
				<simpleCondition key="$keyCode" role="onSelection" />
				<compoundAction operator="seq">
					<simpleAction max="unbounded" qualifier="par" role="start" />
					<simpleAction role="set" max="unbounded" qualifier="seq" value="$var" />
					<simpleAction role="stop" max="unbounded" qualifier="seq" />
				</compoundAction>
			</causalConnector>

			<causalConnector id="onKeySelectionStopN">
				<connectorParam name="keyCode" />
				<simpleCondition key="$keyCode" role="onSelection" />
				<simpleAction max="unbounded" qualifier="par" role="stop" />
			</causalConnector>

			<causalConnector id="onKeySelectionStopNStartN">
				<connectorParam name="keyCode" />
				<simpleCondition key="$keyCode" role="onSelection" />
				<compoundAction operator="seq">
					<simpleAction max="unbounded" qualifier="par" role="stop" />
					<simpleAction max="unbounded" qualifier="par" role="start" />
				</compoundAction>
			</causalConnector>

			<causalConnector id="onKeySelectionSetNStopNStartN">
				<connectorParam name="keyCode" />
				<connectorParam name="var" />
				<simpleCondition key="$keyCode" role="onSelection" />
				<compoundAction operator="seq">
					<simpleAction max="unbounded" qualifier="seq" role="stop" />
					<simpleAction max="unbounded" qualifier="seq" role="start" />
					<simpleAction max="unbounded" qualifier="seq" role="set" value="$var" />
				</compoundAction>
			</causalConnector>

			<causalConnector id="onKeySelectionSetNStopN">
				<connectorParam name="keyCode" />
				<connectorParam name="var" />
				<simpleCondition key="$keyCode" role="onSelection" />
				<compoundAction operator="seq">
					<simpleAction max="unbounded" qualifier="par" role="set" value="$var" />
					<simpleAction max="unbounded" qualifier="par" role="stop" />
				</compoundAction>
			</causalConnector>
			<!-- ####################################
	   #	OnBegin CONNECTORS
	   ###################################-->
			<causalConnector id="onBeginStartNStopN">
				<simpleCondition role="onBegin" />
				<compoundAction operator="seq">
					<simpleAction max="unbounded" qualifier="par" role="start" />
					<simpleAction max="unbounded" qualifier="par" role="stop" />
				</compoundAction>
			</causalConnector>

			<causalConnector id="onBeginStart">
				<simpleCondition role="onBegin" />
				<simpleAction role="start" />
			</causalConnector>

			<causalConnector id="onBeginSet">
				<connectorParam name="val" />
				<simpleCondition role="onBegin" />
				<simpleAction role="set" value="$val" />
			</causalConnector>

			<causalConnector id="onBeginSetN">
				<connectorParam name="var" />
				<simpleCondition role="onBegin" />
				<simpleAction role="set" value="$var" delay="0.3s" qualifier="seq" max="unbounded" />
			</causalConnector>
		</connectorBase>
	</head>
	<body>

		<!-- ###########################
	 # Porta de Entrada
	 ############################ -->
		<port component="imgTelaAbertura" id="ptInicio" />

		<media id="setNode" type="application/x-ginga-settings">
			<property name="service.currentFocus" /> <!-- #### VÃ¡riavel de Sistema que seta o Foco
			atual #### -->
			<property name="service.currentKeyMaster" value="ixLua" /> <!-- ## VÃ¡riavel de Sistema
			que seta quem recebe eventos de Controle Remoto ## -->
			<property name="fullScreen" value="true" /> <!-- ### Flag utilizado para determinar se o
			video estar em FullScreen ### -->
			<property name="startChannel1" value="false" /> <!-- ### Flag utilizado para sinalizar o
			inicio do comercial do Channel 1 -->
			<property name="user.location" /> <!-- Localizacao do usuario -->
		</media>

		<!-- #############################
	 	# Declaracao das midias de Abertura e Comercial
	 	############################# -->
		<!-- #############################<media descriptor="dsFullScreen" id="imgTelaAbertura" src="media/videos/previsao_tempo.mp4">
			-->
		<media descriptor="dsFullScreen" id="imgTelaAbertura" src="media/imagens/background.jpeg">
			<area begin="15s" id="areaDur" />
		</media>

		<media descriptor="dsBackground" id="videoBackground" src="media/videos/previsao_tempo.mp4">
			<area begin="5s" id="areaBackground" />
		</media>

		<media descriptor="dsFullScreen" id="imgTelaEncerramento"
			src="media/imagens/tela_encerramento.png" />
		<media descriptor="dsFullScreen" id="imgTelaApresentacao" src="media/videos/maranhao.mp4" />
		<media descriptor="dsInteratividade" id="imgInteratividade" src="media/videos/comercial.mp4" />

		<media descriptor="dsFullScreen" id="vdoComercial" src="media/videos/comercial.mp4">
			<!-- ### Ancoras Temporais referente aos diferentes comerciais ### -->
			<area begin="16s" end="76s" id="areaInter" />
			<area begin="77s" end="106s" id="propagandaSecundaria" />
			<property name="bounds" /> <!-- ### Propriedade de mÃ­dia relacionada com o tamanho da
			midia ### -->
		</media>


		<!--##############################
			# Elos que irao dar inicio a aplicacao
			##############################-->
		<link xconnector="onBeginStartNStopN">
			<bind component="imgTelaAbertura" interface="areaDur" role="onBegin" />
			<bind component="imgTelaApresentacao" role="start" />
			<bind component="imgTelaAbertura" role="stop" />
		</link>
		<link xconnector="onBeginStart">
			<bind component="videoBackground" interface="areaBackground" role="onBegin"/>
			<bind component="videoBackground" role="start" />
			<bind component="videoBackground" role="stop" />
		</link>
		<link xconnector="onKeySelectionStartNSetNStopN">
			<bind component="imgTelaApresentacao" role="onSelection">
				<bindParam name="keyCode" value="YELLOW" />
			</bind>
			<bind component="vdoComercial" role="start" />
			<bind component="setNode" interface="fullScreen" role="set">
				<bindParam name="var" value="true" />
			</bind>
			<bind component="setNode" interface="startChannel1" role="set">
				<bindParam name="var" value="false" />
			</bind>
			<bind component="imgTelaApresentacao" role="stop" />
		</link>
		<link xconnector="onBeginStart">
			<bind component="vdoComercial" interface="areaInter" role="onBegin" />
			<bind component="imgInteratividade" role="start" />
		</link>
		<link xconnector="onKeySelectionStopNStartN">
			<bind component="imgInteratividade" role="onSelection">
				<bindParam name="keyCode" value="INFO" />
			</bind>
			<bind component="ctxChannel1" role="start" />
			<bind component="imgInteratividade" role="stop" />
		</link>

		<!-- ##################################
	 #	Faz o teste do Flag: fullScreen
	 #	Se tiver fullScreen dispara a interacao do Channel1
	 #	caso contrario a interacao do usuario continua
	 ###################################-->
		<link xconnector="onEndTestStartNStopN">
			<bind component="vdoComercial" interface="areaInter" role="onEnd" />
			<bind component="setNode" interface="fullScreen" role="testFullScreen" />
			<bind component="ctxMaranhao" role="start" />
			<bind component="ctxChannel1" role="stop" />
			<bind component="imgInteratividade" role="stop" />
		</link>

		<!-- ###################################
	 # Seta o Flag: startChannel1 com true
	 #################################### -->
		<link xconnector="onBeginSetN">
			<bind component="vdoComercial" interface="propagandaSecundaria" role="onBegin" />
			<bind component="setNode" interface="startChannel1" role="set">
				<bindParam name="var" value="true" />
			</bind>
		</link>

		<!-- ###################################
	 # No final do video mostra a tela de encerramento
	 #################################### -->
		<link xconnector="onEndStartN">
			<bind component="vdoComercial" role="onEnd" />
			<bind component="imgTelaEncerramento" role="start" />
		</link>

		<!-- ####################################
	 # Caso usuario aperte
	 #	AMARELO: reeinicia a aplicacao
	 # 	AZUL: encerra a aplicacao
	 #################################### -->
		<link xconnector="onKeySelectionStartNSetNStopN">
			<bind component="imgTelaEncerramento" role="onSelection">
				<bindParam name="keyCode" value="YELLOW" />
			</bind>
			<bind component="imgTelaAbertura" role="start" />
			<bind component="setNode" interface="fullScreen" role="set">
				<bindParam name="var" value="true" />
			</bind>
			<bind component="setNode" interface="startChannel1" role="set">
				<bindParam name="var" value="false" />
			</bind>
			<bind component="imgTelaEncerramento" role="stop" />
		</link>
		<link xconnector="onKeySelectionStopN">
			<bind component="imgTelaEncerramento" role="onSelection">
				<bindParam name="keyCode" value="BLUE" />
			</bind>
			<bind component="imgTelaEncerramento" role="stop" />
		</link>
		<port id="pt1" component="videoBackground" />
		<context id="ctxChannel1">

			<context id="ctxCondicoes">
				<port id="ptoCtxRef1TelaInter" component="telaInterRef1" />
				<port id="ptoConteudoFundo" component="imgFundoConteudo" />
				

				<port component="imgBtnCondicoesVolta" id="ptoCondicoesBtn" />

				<media id="modalTrocaConteudo" src="media/imagens/modal_troca.png"
					descriptor="dsFullScreen" />
				<media descriptor="dsCondicoesBtn" id="imgBtnCondicoesVolta"
					src="media/imagens/condominio/condicoes/botoesCondicoes.png" />

				<media id="imgFundoConteudo"
					src="media/imagens/condominio/condicoes/boxConteudo.png"
					descriptor="dsConteudoFundo" />
				<media descriptor="dsConteudoTexto" id="propagandaMaranhao"
					src="media/videos/maranhao.mp4" />
				<media descriptor="dsConteudoTexto" id="imgConteudoQuarto2"
					src="media/imagens/condominio/condicoes/text2.png" />
				<media descriptor="dsConteudoTexto" id="imgConteudoQuarto3"
					src="media/imagens/condominio/condicoes/text3.png" />

				<media id="focusNodeCondicoes" instance="instSame" refer="setNode" />
				<media id="vdoComercialRef2" instance="instSame" refer="vdoComercial" />
				<context id="telaInterRef1" refer="ctxTelaInteracao" />


				<!-- ##########################################
	     # Navegacao pelos tipos de apartamentos disponiveis
	     # Utilizando onEndAttributtion do currentFocus
	     # Evita utilizar o botao OK
	     ###########################################-->
				<link xconnector="onEndAttributionTestStopNStartN">
					<bind component="focusNodeCondicoes" interface="service.currentFocus"
						role="onEndAttribution" />
					<bind component="focusNodeCondicoes" interface="service.currentFocus"
						role="attNodeTest">
						<bindParam name="varTest" value="1" />
					</bind>
					<bind component="imgConteudoQuarto2" role="stop" />
					<bind component="imgConteudoQuarto3" role="stop" />
					<bind component="propagandaMaranhao" role="start" />
				</link>
				<link xconnector="onEndAttributionTestStopNStartN">
					<bind component="focusNodeCondicoes" interface="service.currentFocus"
						role="onEndAttribution" />
					<bind component="focusNodeCondicoes" interface="service.currentFocus"
						role="attNodeTest">
						<bindParam name="varTest" value="2" />
					</bind>
					<bind component="propagandaMaranhao" role="stop" />
					<bind component="imgConteudoQuarto3" role="stop" />
					<bind component="imgConteudoQuarto2" role="start" />
				</link>
				<link xconnector="onEndAttributionTestStopNStartN">
					<bind component="focusNodeCondicoes" interface="service.currentFocus"
						role="onEndAttribution" />
					<bind component="focusNodeCondicoes" interface="service.currentFocus"
						role="attNodeTest">
						<bindParam name="varTest" value="3" />
					</bind>
					<bind component="propagandaMaranhao" role="stop" />
					<bind component="imgConteudoQuarto2" role="stop" />
					<bind component="imgConteudoQuarto3" role="start" />
				</link>

				<!-- ### Volta para o menu anterior com o video 100% ### -->
				<link xconnector="onKeySelectionSetNStopN">
					<bind component="imgBtnCondicoesVolta" role="onSelection">
						<bindParam name="keyCode" value="BLUE" />
					</bind>
					<bind component="ctxCondicoes" role="stop" />
					<bind component="vdoComercialRef2" interface="bounds" role="set">
						<bindParam name="var" value="0, 0, 640, 480" />
					</bind>
					<bind component="focusNodeCondicoes" interface="fullScreen" role="set">
						<bindParam name="var" value="true" />
					</bind>
				</link>
			</context>

			<!-- ##############################
	   # Contexto que gerencia as unidades disponiveis
	   ############################### -->
			<context id="ctxUnidades">

				<media id="focusNodeUnidades" instance="instSame" refer="setNode" />
				<media id="vdoComercialRef3" instance="instSame" refer="vdoComercial" />
				<context id="telaInterRef2" refer="ctxTelaInteracao" />

				<!-- ### Volta para o menu anterior com o video 100% ### -->


			</context>

			<!-- ### Vai para a tela de unidades a partir da tela de condicoes ### -->
			<link xconnector="onKeySelectionStopNStartN">
				<bind component="ctxCondicoes" interface="ptoCondicoesBtn" role="onSelection">
					<bindParam name="keyCode" value="YELLOW" />
				</bind>
				<bind component="ctxCondicoes" role="stop" />
				<bind component="ctxUnidades" role="start" />
			</link>

		</context>

		<context id="ctxMaranhao">

			<!-- <media descriptor="dsLua" id="luaCep" src="media/lua/cep.lua">
        <property name="location" />
      </media> -->



		</context>

	</body>
</ncl>