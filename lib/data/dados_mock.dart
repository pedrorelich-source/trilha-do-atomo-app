import 'package:flutter/material.dart';

import '../models/estacao.dart';

/// Dados mockados da Sprint 1 — os mesmos conteúdos (com fontes verificadas)
/// que a API Java grava no Oracle. Na Sprint 2 o app passa a consumir a API.
const List<Estacao> estacoesMock = [
  Estacao(
    id: 'medicina-nuclear',
    area: 'Medicina nuclear',
    icone: Icons.medical_services,
    titulo: 'Radiofármacos: medicina que enxerga por dentro',
    resumo:
        'Radiofármacos são produtos químicos com elementos radioativos usados no diagnóstico e no tratamento de doenças em oncologia, cardiologia, hematologia e neurologia. No Brasil, o IPEN, autarquia da CNEN, atende a maior parte da demanda nacional de medicina nuclear.',
    beneficio: 'Diagnóstico e tratamento de doenças a partir do funcionamento dos órgãos.',
    nivel: 1,
    fonte: 'Revista Pesquisa FAPESP — "Radiofármacos sob ameaça" (nov. 2021)',
    desafios: [
      Desafio(
        afirmacao: 'Radiofármacos são usados tanto no diagnóstico quanto no tratamento de doenças.',
        verdadeiro: true,
        explicacao: 'Verdade. Eles são empregados no diagnóstico e no tratamento de doenças em áreas como oncologia, cardiologia, hematologia e neurologia.',
        pontos: 10,
      ),
    ],
  ),
  Estacao(
    id: 'radioterapia',
    area: 'Radioterapia',
    icone: Icons.local_hospital,
    titulo: 'Radioterapia contra o câncer',
    resumo:
        'A radioterapia é um tratamento que utiliza radiações ionizantes, como os raios X, para destruir as células de um tumor ou impedir que elas se multipliquem.',
    beneficio: 'Tratamento de diversos tipos de câncer, sozinho ou combinado com outras terapias.',
    nivel: 1,
    fonte: 'INCA — Instituto Nacional de Câncer: Radioterapia',
    desafios: [
      Desafio(
        afirmacao: 'A radioterapia usa radiação ionizante para destruir células de tumores ou impedir que se multipliquem.',
        verdadeiro: true,
        explicacao: 'Verdade. Segundo o INCA, é exatamente esse o princípio da radioterapia.',
        pontos: 10,
      ),
    ],
  ),
  Estacao(
    id: 'agricultura',
    area: 'Agricultura',
    icone: Icons.agriculture,
    titulo: 'Técnica do inseto estéril',
    resumo:
        'Insetos-praga são criados em grande quantidade e esterilizados com radiação (raios gama ou X). Os machos estéreis são liberados no campo, acasalam com fêmeas selvagens e não geram descendentes, reduzindo a população da praga. A técnica não envolve modificação genética.',
    beneficio: 'Controle de pragas com menos inseticidas e sem introduzir espécies estranhas no ambiente.',
    nivel: 2,
    fonte: 'IAEA — Sterile insect technique',
    desafios: [
      Desafio(
        afirmacao: 'Na técnica do inseto estéril, os insetos são modificados geneticamente.',
        verdadeiro: false,
        explicacao: 'Mito. Os insetos são esterilizados com radiação; a técnica não usa engenharia genética.',
        pontos: 25,
      ),
      Desafio(
        afirmacao: 'Machos estéreis soltos no campo acasalam com fêmeas selvagens, que então não geram descendentes.',
        verdadeiro: true,
        explicacao: 'Verdade. Assim a população da praga diminui a cada geração, sem uso de inseticidas.',
        pontos: 15,
      ),
    ],
  ),
  Estacao(
    id: 'alimentos',
    area: 'Alimentos',
    icone: Icons.restaurant,
    titulo: 'Irradiação de alimentos',
    resumo:
        'Alimentos podem ser tratados com raios gama, raios X ou feixes de elétrons. A técnica controla microrganismos que causam doenças e pragas sem mudar a temperatura do alimento e sem deixar resíduos. Mais de 60 países têm regras que permitem seu uso.',
    beneficio: 'Alimentos mais seguros, que duram mais e chegam ao consumidor com menos desperdício.',
    nivel: 1,
    fonte: 'IAEA — Food irradiation',
    desafios: [
      Desafio(
        afirmacao: 'Alimentos irradiados ficam radioativos.',
        verdadeiro: false,
        explicacao: 'Mito. A irradiação usa doses controladas de raios gama, raios X ou feixes de elétrons e não deixa resíduos no alimento — assim como você não fica radioativo depois de um exame de raio X.',
        pontos: 20,
      ),
      Desafio(
        afirmacao: 'Com a irradiação, não é mais preciso manusear e cozinhar o alimento corretamente.',
        verdadeiro: false,
        explicacao: 'Mito. A irradiação reduz microrganismos e o desperdício, mas os cuidados normais de higiene e cozimento continuam necessários.',
        pontos: 15,
      ),
    ],
  ),
  Estacao(
    id: 'industria',
    area: 'Indústria',
    icone: Icons.factory,
    titulo: 'Ensaios não destrutivos na indústria',
    resumo:
        'Técnicas nucleares de ensaio não destrutivo, como a radiografia industrial, permitem inspecionar soldas, tubulações e estruturas por dentro, sem cortar ou danificar a peça.',
    beneficio: 'Mais segurança em pontes, dutos e indústrias, com inspeções sem destruir o material.',
    nivel: 2,
    fonte: 'IAEA — Industry (Non-Destructive Testing)',
    desafios: [
      Desafio(
        afirmacao: 'Para inspecionar uma solda com técnicas nucleares é preciso cortar e destruir a peça.',
        verdadeiro: false,
        explicacao: 'Mito. Os ensaios não destrutivos, como a radiografia industrial, inspecionam a peça por dentro sem danificá-la.',
        pontos: 15,
      ),
    ],
  ),
  Estacao(
    id: 'esterilizacao',
    area: 'Esterilização',
    icone: Icons.sanitizer,
    titulo: 'Esterilização de materiais médicos por radiação',
    resumo:
        'A radiação pode esterilizar produtos já embalados. Exemplos de produtos esterilizados comercialmente: luvas e kits cirúrgicos, seringas descartáveis, suturas, implantes e agulhas.',
    beneficio: 'Materiais médicos estéreis, prontos para uso, protegendo pacientes contra infecções.',
    nivel: 1,
    fonte: 'IEN/CNEN — Perguntas frequentes',
    desafios: [
      Desafio(
        afirmacao: 'Seringas descartáveis e luvas cirúrgicas podem ser esterilizadas com radiação.',
        verdadeiro: true,
        explicacao: 'Verdade. Esses produtos são esterilizados comercialmente com radiação, inclusive já dentro da embalagem.',
        pontos: 10,
      ),
    ],
  ),
  Estacao(
    id: 'energia',
    area: 'Energia elétrica',
    icone: Icons.bolt,
    titulo: 'Angra 1: a primeira usina nuclear brasileira',
    resumo:
        'A usina Angra 1, em Angra dos Reis (RJ), entrou em operação comercial em 1985 e usa um reator de água pressurizada (PWR), o tipo mais utilizado no mundo.',
    beneficio: 'Geração de eletricidade de forma contínua, complementando outras fontes da matriz brasileira.',
    nivel: 1,
    fonte: 'Eletronuclear — Angra 1',
    desafios: [
      Desafio(
        afirmacao: 'O Brasil não tem nenhuma usina nuclear em operação.',
        verdadeiro: false,
        explicacao: 'Mito. Angra 1 opera comercialmente desde 1985, em Angra dos Reis (RJ).',
        pontos: 15,
      ),
      Desafio(
        afirmacao: 'Angra 1 usa um reator de água pressurizada (PWR), o tipo mais usado no mundo.',
        verdadeiro: true,
        explicacao: 'Verdade. Esse é o tipo de reator informado pela Eletronuclear para Angra 1.',
        pontos: 20,
      ),
    ],
  ),
  Estacao(
    id: 'propulsao-naval',
    area: 'Propulsão naval',
    icone: Icons.directions_boat,
    titulo: 'Labgene e o submarino de propulsão nuclear',
    resumo:
        'O Laboratório de Geração de Energia Nucleoelétrica (Labgene) foi montado para testar em terra o reator que vai gerar energia térmica para a propulsão do submarino brasileiro, projeto do Programa Nuclear da Marinha.',
    beneficio: 'Desenvolvimento de tecnologia nacional com aplicações militares e civis.',
    nivel: 2,
    fonte: 'Revista Pesquisa FAPESP — "Brasil dá mais um passo na construção do submarino nuclear"',
    desafios: [
      Desafio(
        afirmacao: 'O Labgene foi criado para testar em terra o reator do submarino brasileiro de propulsão nuclear.',
        verdadeiro: true,
        explicacao: 'Verdade. O laboratório foi montado para testar o reator que vai gerar energia para a propulsão do submarino.',
        pontos: 20,
      ),
    ],
  ),
  Estacao(
    id: 'pesquisa',
    area: 'Pesquisa científica',
    icone: Icons.science,
    titulo: 'Reator Multipropósito Brasileiro (RMB)',
    resumo:
        'O RMB é um reator de pesquisa projetado pela CNEN. Entre suas funções está a produção de radioisótopos em posições do tanque refletor, matéria-prima de radiofármacos usados na medicina.',
    beneficio: 'Mais autonomia do Brasil na produção de insumos para a medicina nuclear e para a pesquisa.',
    nivel: 3,
    fonte: 'CNEN — O Reator Multipropósito Brasileiro',
    desafios: [
      Desafio(
        afirmacao: 'O Reator Multipropósito Brasileiro também servirá para produzir radioisótopos.',
        verdadeiro: true,
        explicacao: 'Verdade. A produção de radioisótopos, matéria-prima de radiofármacos, é uma das funções previstas no projeto.',
        pontos: 25,
      ),
    ],
  ),
  Estacao(
    id: 'recursos-hidricos',
    area: 'Recursos hídricos',
    icone: Icons.water_drop,
    titulo: 'Isótopos que contam a história da água',
    resumo:
        'Técnicas isotópicas fornecem informações sobre as fontes de água e o impacto humano no clima, apoiando a avaliação e a gestão de recursos hídricos.',
    beneficio: 'Uso mais seguro e sustentável da água potável.',
    nivel: 3,
    fonte: 'IAEA — Water',
    desafios: [
      Desafio(
        afirmacao: 'Técnicas com isótopos podem fornecer informações sobre as fontes de água.',
        verdadeiro: true,
        explicacao: 'Verdade. A hidrologia isotópica é usada para avaliar e gerenciar recursos hídricos.',
        pontos: 20,
      ),
    ],
  ),
];
