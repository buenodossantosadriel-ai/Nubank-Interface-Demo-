import 'package:flutter/material.dart';

const purple = Color(0xFF830AD1);
const purpleLight = Color(0xFF9028D7);
const ink = Color(0xFF191919);
const muted = Color(0xFF737373);
const pale = Color(0xFFF0F1F5);
const hidden = Color(0xFFF5F5F5);

void main() => runApp(const InterfaceDemoApp());

class InterfaceDemoApp extends StatelessWidget {
  const InterfaceDemoApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Interface Demo',
        theme: ThemeData(
          useMaterial3: false,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Roboto',
          colorScheme: ColorScheme.fromSeed(seedColor: purple),
          textTheme: const TextTheme(
            titleMedium: TextStyle(fontSize: 17, color: muted, fontWeight: FontWeight.w300, letterSpacing: -0.5),
            titleSmall: TextStyle(color: muted, fontWeight: FontWeight.normal),
            displaySmall: TextStyle(fontSize: 35, color: ink, fontWeight: FontWeight.w500, letterSpacing: -1.5),
            headlineMedium: TextStyle(fontSize: 30, color: ink, fontWeight: FontWeight.w500, letterSpacing: -1.5),
            labelLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            bodySmall: TextStyle(height: 1.5),
            headlineSmall: TextStyle(fontWeight: FontWeight.bold),
            titleLarge: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        home: const HomeScreen(),
      );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showValues = true;
  final username = 'Adriel';

  void demoSheet(String title, String detail) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 18, 24, 32),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(child: Container(width: 38, height: 4, decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(5)))),
            const SizedBox(height: 24),
            Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: ink)),
            const SizedBox(height: 12),
            Text(detail, style: const TextStyle(fontSize: 14, color: muted, height: 1.5)),
            const SizedBox(height: 22),
            Container(width: double.infinity, padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: pale, borderRadius: BorderRadius.circular(10)), child: const Text('AMBIENTE DE DEMONSTRAÇÃO • Nenhuma operação financeira é realizada.', style: TextStyle(fontSize: 11, color: muted))),
            const SizedBox(height: 16),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: purple, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14)), child: const Text('Entendi'))),
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [purple, Colors.white], stops: [0.5, 0.5])),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                _header(),
                Container(color: Colors.white, padding: const EdgeInsets.only(bottom: 26), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  _accountCard(),
                  const SizedBox(height: 10),
                  _quickActions(),
                  _myCards(),
                  _textPromos(),
                  const SizedBox(height: 20),
                  const Divider(height: 2, thickness: .5),
                  _featureCard('Cartão de Crédito', 'Fatura atual', 'R\$ 780,72', 'Limite disponível R\$ 806,78', Icons.credit_card_outlined, () => demoSheet('Cartão de Crédito', 'Resumo demonstrativo da fatura e do limite disponível.')),
                  _featureCard('Empréstimo', 'Valor disponível de até', 'R\$ 10.000,00', '', Icons.person_outline, () => demoSheet('Empréstimo', 'Simulação visual. Não há contratação ou consulta de crédito.')),
                  _featureCard('Investimentos', 'A revolução roxa começou. Invista de maneira simples, sem burocracia e 100% digital.', '', '', Icons.show_chart, () => demoSheet('Investimentos', 'Área demonstrativa de investimentos.')),
                  _featureCard('Seguro de vida', 'Conheça uma experiência simples e que cabe no bolso.', '', '', Icons.favorite_border, () => demoSheet('Seguro de vida', 'Conteúdo demonstrativo.')),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20), child: Text('Descubra mais', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: ink))),
                  _discover(),
                ])),
              ]),
            ),
          ),
        ),
      );

  Widget _header() => Container(
        color: purple,
        padding: const EdgeInsets.fromLTRB(18, 14, 16, 25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            _roundIcon(Icons.person_outline, () => demoSheet('Perfil', 'Área de perfil demonstrativa.')),
            Row(children: [
              IconButton(onPressed: () => setState(() => showValues = !showValues), icon: Icon(showValues ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Colors.white)),
              IconButton(onPressed: () => demoSheet('Ajuda', 'Central de ajuda demonstrativa.'), icon: const Icon(Icons.help_outline, color: Colors.white)),
              IconButton(onPressed: () => demoSheet('Convide amigos', 'Compartilhamento demonstrativo.'), icon: const Icon(Icons.forward_to_inbox_outlined, color: Colors.white)),
            ]),
          ]),
          const SizedBox(height: 30),
          Text('Olá, $username', style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600)),
        ]),
      );

  Widget _roundIcon(IconData icon, VoidCallback tap) => Material(color: Colors.white24, shape: const CircleBorder(), child: InkWell(customBorder: const CircleBorder(), onTap: tap, child: SizedBox(width: 42, height: 42, child: Icon(icon, color: Colors.white))));

  Widget _accountCard() => InkWell(
        onTap: () => demoSheet('Conta', 'Saldo e movimentações fictícias para visualização da interface.'),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 22, 24, 18),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Row(children: [Text('Conta', style: TextStyle(fontSize: 16, color: ink, fontWeight: FontWeight.w500)), Spacer(), Icon(Icons.chevron_right, color: muted)]),
            const SizedBox(height: 16),
            Text(showValues ? 'R\$ 181,79' : '••••••', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: ink)),
          ]),
        ),
      );

  Widget _quickActions() {
    final actions = <(String, IconData)>[
      ('Pix', Icons.qr_code_2), ('Pagar', Icons.qr_code_scanner), ('Transferir', Icons.swap_horiz),
      ('Depositar', Icons.south_west), ('Empréstimos', Icons.person_outline),
      ('Recarga de celular', Icons.phone_android), ('Cobrar', Icons.call_made),
      ('Doação', Icons.favorite_border), ('Encontrar atalhos', Icons.grid_view),
    ];
    return SingleChildScrollView(scrollDirection: Axis.horizontal, physics: const BouncingScrollPhysics(), child: Row(children: [
      const SizedBox(width: 20),
      for (final action in actions) Padding(padding: const EdgeInsets.only(right: 10), child: SizedBox(width: 76, child: Column(children: [
        Material(color: pale, shape: const CircleBorder(), child: InkWell(customBorder: const CircleBorder(), onTap: () => demoSheet(action.$1, 'Esta opção está disponível somente como demonstração visual.'), child: SizedBox(width: 64, height: 64, child: Icon(action.$2, color: ink, size: 25)))),
        const SizedBox(height: 8),
        Text(action.$1, textAlign: TextAlign.center, maxLines: 2, style: const TextStyle(fontSize: 11, height: 1.25, color: ink, fontWeight: FontWeight.w500)),
      ]))),
      const SizedBox(width: 12),
    ]));
  }

  Widget _myCards() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Material(color: pale, borderRadius: BorderRadius.circular(10), child: InkWell(borderRadius: BorderRadius.circular(10), onTap: () => demoSheet('Meus cartões', 'Visualização demonstrativa dos cartões.'), child: const Padding(padding: EdgeInsets.all(15), child: Row(children: [Icon(Icons.credit_card_outlined, color: ink), SizedBox(width: 12), Text('Meus cartões', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: ink))])))),
      );

  Widget _textPromos() => SingleChildScrollView(scrollDirection: Axis.horizontal, physics: const BouncingScrollPhysics(), child: Row(children: [
    const SizedBox(width: 24),
    _promo('Você tem R\$ 10.000,00 disponíveis para ', 'empréstimo.'),
    _promo('Conquiste planos futuros: conheça as opções para ', 'guardar dinheiro.'),
    const SizedBox(width: 10),
  ]));

  Widget _promo(String text, String highlight) => Container(width: 280, margin: const EdgeInsets.only(right: 14), decoration: BoxDecoration(color: pale, borderRadius: BorderRadius.circular(10)), child: InkWell(borderRadius: BorderRadius.circular(10), onTap: () => demoSheet('Conheça', 'Conteúdo demonstrativo.'), child: Padding(padding: const EdgeInsets.all(25), child: RichText(maxLines: 2, overflow: TextOverflow.ellipsis, text: TextSpan(style: const TextStyle(color: ink, fontSize: 14, height: 1.4), children: [TextSpan(text: text), TextSpan(text: highlight, style: const TextStyle(color: purple, fontWeight: FontWeight.w600))])))));

  Widget _featureCard(String title, String description, String value, String extra, IconData icon, VoidCallback tap) => InkWell(onTap: tap, child: Padding(padding: const EdgeInsets.fromLTRB(24, 22, 24, 22), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Icon(icon, color: muted, size: 22), const SizedBox(width: 16),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: ink)),
      const SizedBox(height: 18),
      if (value.isNotEmpty) ...[
        Text(description, style: const TextStyle(fontSize: 13, color: muted, fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        if (showValues) Text(value, style: const TextStyle(fontSize: 22, color: ink, fontWeight: FontWeight.w700)) else Container(height: 28, width: 150, color: hidden),
        if (extra.isNotEmpty) ...[const SizedBox(height: 5), Text(extra, style: const TextStyle(fontSize: 12, color: muted))],
      ] else Text(description, style: const TextStyle(fontSize: 13, color: muted, height: 1.5, fontWeight: FontWeight.w500)),
    ])),
    const Icon(Icons.chevron_right, color: muted),
  ])));

  Widget _discover() => SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [
    const SizedBox(width: 24),
    _discoverCard('WhatsApp', 'Pagamentos seguros, rápidos e sem tarifa. Uma experiência prática sem sair da conversa.', 'Quero conhecer', true),
    _discoverCard('Indique seus amigos', 'Mostre aos seus amigos como é fácil ter uma vida sem burocracia.', 'Indicar amigos', false),
    const SizedBox(width: 14),
  ]));

  Widget _discoverCard(String title, String content, String button, bool isNew) => Container(width: 300, margin: const EdgeInsets.only(right: 15), decoration: BoxDecoration(color: pale, borderRadius: BorderRadius.circular(10)), child: InkWell(borderRadius: BorderRadius.circular(10), onTap: () => demoSheet(title, 'Conteúdo demonstrativo.'), child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(children: [Flexible(child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: ink))), if (isNew) ...[const SizedBox(width: 5), Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: purple, borderRadius: BorderRadius.circular(5)), child: const Text('Novo', style: TextStyle(color: Colors.white, fontSize: 10)))]]),
    const SizedBox(height: 10),
    Text(content, maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: muted, height: 1.5)),
    const SizedBox(height: 18),
    Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9), decoration: BoxDecoration(color: purple, borderRadius: BorderRadius.circular(22)), child: Text(button, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600))),
  ]))));
}
