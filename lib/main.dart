import 'package:flutter/material.dart';

const purple = Color(0xFF830AD1);
const ink = Color(0xFF191919);
const muted = Color(0xFF737373);
const pale = Color(0xFFF0F1F5);

void main() => runApp(const InterfaceDemoApp());

class Movement {
  Movement(this.title, this.description, this.amount, this.date);
  final String title, description;
  final double amount;
  final DateTime date;
}

class InterfaceDemoApp extends StatelessWidget {
  const InterfaceDemoApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Interface Demo',
    theme: ThemeData(useMaterial3: false, scaffoldBackgroundColor: Colors.white, fontFamily: 'Roboto', colorScheme: ColorScheme.fromSeed(seedColor: purple)),
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
  String username = 'Adriel';
  double balance = 181.79;
  final List<Movement> movements = [Movement('Saldo inicial', 'Lançamento demonstrativo', 181.79, DateTime.now())];

  String money(double v) => 'R\$ ' + v.abs().toStringAsFixed(2).replaceAll('.', ',');
  String dateText(DateTime d) => d.day.toString().padLeft(2, '0') + '/' + d.month.toString().padLeft(2, '0') + '/' + d.year.toString() + ' ' + d.hour.toString().padLeft(2, '0') + ':' + d.minute.toString().padLeft(2, '0');

  void message(String title, String body) {
    showModalBottomSheet<void>(context: context, backgroundColor: Colors.white, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(22))), builder: (ctx) => SafeArea(child: Padding(
      padding: const EdgeInsets.all(24), child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: ink)),
        const SizedBox(height: 12), Text(body, style: const TextStyle(color: muted, height: 1.5)),
        const SizedBox(height: 16), const DemoBanner(), const SizedBox(height: 16),
        SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Navigator.pop(ctx), style: ElevatedButton.styleFrom(backgroundColor: purple, foregroundColor: Colors.white), child: const Text('Fechar'))),
      ]),
    )));
  }

  void settings() {
    final name = TextEditingController(text: username);
    final amount = TextEditingController(text: balance.toStringAsFixed(2).replaceAll('.', ','));
    showModalBottomSheet<void>(context: context, isScrollControlled: true, backgroundColor: Colors.white, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(22))), builder: (ctx) => Padding(
      padding: EdgeInsets.fromLTRB(22, 24, 22, MediaQuery.of(ctx).viewInsets.bottom + 24),
      child: SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
        const Text('Configurar conta demo', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: ink)),
        const SizedBox(height: 8), const Text('Altere o nome e o saldo fictício exibidos na tela.', style: TextStyle(color: muted)),
        const SizedBox(height: 18), field(name, 'Nome exibido', icon: Icons.person_outline),
        const SizedBox(height: 12), field(amount, 'Saldo demonstrativo (R\$)', keyboard: TextInputType.number, icon: Icons.account_balance_wallet_outlined),
        const SizedBox(height: 14), const DemoBanner(), const SizedBox(height: 18),
        SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {
          final parsed = double.tryParse(amount.text.trim().replaceAll('.', '').replaceAll(',', '.'));
          if (name.text.trim().isEmpty || parsed == null || parsed < 0) {
            message('Dados inválidos', 'Informe um nome e um saldo demonstrativo válido.');
            return;
          }
          setState(() { username = name.text.trim(); balance = parsed; });
          Navigator.pop(ctx);
        }, style: ElevatedButton.styleFrom(backgroundColor: purple, foregroundColor: Colors.white, padding: const EdgeInsets.all(14)), child: const Text('Salvar configuração'))),
      ])),
    ));
  }

  void pix() => operation('Enviar Pix • demonstração', 'Pix', 'Chave Pix do destinatário', 'CPF, e-mail, telefone ou chave aleatória');
  void transfer() => operation('Transferência • demonstração', 'Transferência', 'Destinatário', 'Nome fictício do destinatário');

  void operation(String title, String type, String recipientLabel, String hint) {
    final recipient = TextEditingController();
    final amount = TextEditingController();
    final description = TextEditingController();
    showModalBottomSheet<void>(context: context, isScrollControlled: true, backgroundColor: Colors.white, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(22))), builder: (ctx) => Padding(
      padding: EdgeInsets.fromLTRB(22, 24, 22, MediaQuery.of(ctx).viewInsets.bottom + 24),
      child: SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
        Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: ink)),
        const SizedBox(height: 8), const Text('Preencha os campos para montar uma simulação.', style: TextStyle(color: muted)),
        const SizedBox(height: 18), field(recipient, recipientLabel, hint: hint),
        const SizedBox(height: 12), field(amount, 'Valor fictício (R\$)', hint: '0,00', keyboard: const TextInputType.numberWithOptions(decimal: true)),
        const SizedBox(height: 12), field(description, 'Descrição que aparecerá no extrato', hint: 'Ex.: almoço, teste, aluguel'),
        const SizedBox(height: 14), const DemoBanner(), const SizedBox(height: 18),
        SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {
          final parsed = double.tryParse(amount.text.trim().replaceAll('.', '').replaceAll(',', '.'));
          if (recipient.text.trim().isEmpty || parsed == null || parsed <= 0) {
            message('Confira os dados', 'Informe o destinatário/chave e um valor maior que zero.');
            return;
          }
          Navigator.pop(ctx);
          review(type, recipient.text.trim(), parsed, description.text.trim());
        }, style: ElevatedButton.styleFrom(backgroundColor: purple, foregroundColor: Colors.white, padding: const EdgeInsets.all(14)), child: const Text('Revisar simulação'))),
      ])),
    ));
  }

  void review(String type, String recipient, double amount, String description) {
    showModalBottomSheet<void>(context: context, backgroundColor: Colors.white, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(22))), builder: (ctx) => SafeArea(child: Padding(
      padding: const EdgeInsets.all(24), child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Icon(Icons.visibility_outlined, color: purple, size: 34),
        const SizedBox(height: 10), const Text('Revisão da simulação', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: ink)),
        const SizedBox(height: 16), detail('Tipo', type), detail('Destinatário', recipient), detail('Valor fictício', money(amount)), detail('Descrição no extrato', description.isEmpty ? type : description),
        const SizedBox(height: 14), const DemoBanner(), const SizedBox(height: 18),
        SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {
          setState(() => movements.insert(0, Movement(type, (description.isEmpty ? type : description) + ' • ' + recipient + ' • SIMULADO', -amount, DateTime.now())));
          Navigator.pop(ctx);
          message('Lançamento de demonstração criado', 'O item fictício foi incluído no extrato desta sessão. Nenhum Pix ou transferência foi enviado e o saldo não foi movimentado.');
        }, style: ElevatedButton.styleFrom(backgroundColor: purple, foregroundColor: Colors.white, padding: const EdgeInsets.all(14)), child: const Text('Adicionar ao extrato demo'))),
      ]),
    )));
  }

  void addMovement() {
    final title = TextEditingController(), description = TextEditingController(), amount = TextEditingController();
    showModalBottomSheet<void>(context: context, isScrollControlled: true, backgroundColor: Colors.white, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(22))), builder: (ctx) => Padding(
      padding: EdgeInsets.fromLTRB(22, 24, 22, MediaQuery.of(ctx).viewInsets.bottom + 24),
      child: SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
        const Text('Adicionar item ao extrato demo', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: ink)),
        const SizedBox(height: 16), field(title, 'Título', hint: 'Ex.: Compra, pagamento, depósito'),
        const SizedBox(height: 12), field(description, 'Descrição', hint: 'Texto exibido no extrato'),
        const SizedBox(height: 12), field(amount, 'Valor (R\$)', hint: 'Negativo para saída', keyboard: const TextInputType.numberWithOptions(decimal: true, signed: true)),
        const SizedBox(height: 14), const DemoBanner(), const SizedBox(height: 16),
        SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {
          final parsed = double.tryParse(amount.text.trim().replaceAll('.', '').replaceAll(',', '.'));
          if (title.text.trim().isEmpty || parsed == null || parsed == 0) {
            message('Confira os dados', 'Informe título e valor diferente de zero. Use negativo para saída.');
            return;
          }
          setState(() => movements.insert(0, Movement(title.text.trim(), description.text.trim() + ' • SIMULADO', parsed, DateTime.now())));
          Navigator.pop(ctx);
        }, style: ElevatedButton.styleFrom(backgroundColor: purple, foregroundColor: Colors.white), child: const Text('Adicionar lançamento'))),
      ])),
    ));
  }

  void statement() {
    showModalBottomSheet<void>(context: context, isScrollControlled: true, backgroundColor: Colors.white, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(22))), builder: (ctx) => DraggableScrollableSheet(
      expand: false, initialChildSize: .78, minChildSize: .45, maxChildSize: .92,
      builder: (ctx, scroll) => Padding(padding: const EdgeInsets.fromLTRB(20, 20, 20, 12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Extrato da conta demo', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: ink)),
        const SizedBox(height: 5), const Text('Movimentações fictícias desta sessão.', style: TextStyle(color: muted)),
        const SizedBox(height: 12), const DemoBanner(), const SizedBox(height: 8),
        Expanded(child: ListView.separated(controller: scroll, itemCount: movements.length, separatorBuilder: (_, __) => const Divider(height: 1), itemBuilder: (_, i) {
          final item = movements[i];
          return ListTile(contentPadding: EdgeInsets.zero, leading: CircleAvatar(backgroundColor: pale, child: Icon(item.amount < 0 ? Icons.arrow_upward : Icons.arrow_downward, color: purple)), title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w600, color: ink)), subtitle: Text(item.description + '\n' + dateText(item.date), style: const TextStyle(color: muted, height: 1.5)), isThreeLine: true, trailing: Text((item.amount < 0 ? '−' : '+') + money(item.amount), style: TextStyle(fontWeight: FontWeight.bold, color: item.amount < 0 ? ink : Colors.green)));
        })),
        SizedBox(width: double.infinity, child: OutlinedButton.icon(onPressed: () { Navigator.pop(ctx); addMovement(); }, icon: const Icon(Icons.edit_note), label: const Text('Adicionar lançamento fictício'))),
      ])),
    ));
  }

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [purple, Colors.white], stops: [0.5, 0.5])),
    child: SafeArea(child: Scaffold(backgroundColor: Colors.transparent, body: SingleChildScrollView(physics: const BouncingScrollPhysics(), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      header(),
      Container(color: Colors.white, padding: const EdgeInsets.only(bottom: 26), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        accountCard(), const SizedBox(height: 10), quickActions(), myCards(), promos(),
        const SizedBox(height: 20), const Divider(height: 2, thickness: .5),
        feature('Cartão de Crédito', 'Fatura atual', 'R\$ 780,72', 'Limite disponível R\$ 806,78', Icons.credit_card_outlined, () => message('Cartão de Crédito', 'Resumo demonstrativo da fatura e do limite.')),
        feature('Empréstimo', 'Valor disponível de até', 'R\$ 10.000,00', '', Icons.person_outline, () => message('Empréstimo', 'Simulação visual, sem contratação.')),
        feature('Investimentos', 'A revolução roxa começou. Invista de maneira simples, sem burocracia e 100% digital.', '', '', Icons.show_chart, () => message('Investimentos', 'Área demonstrativa.')),
        feature('Seguro de vida', 'Conheça uma experiência simples e que cabe no bolso.', '', '', Icons.favorite_border, () => message('Seguro de vida', 'Conteúdo demonstrativo.')),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20), child: Text('Descubra mais', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: ink))),
        discover(),
      ])),
    ])))),
  );

  Widget header() => Container(color: purple, padding: const EdgeInsets.fromLTRB(18, 14, 16, 25), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      roundIcon(Icons.person_outline, settings),
      Row(children: [
        IconButton(onPressed: () => setState(() => showValues = !showValues), icon: Icon(showValues ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Colors.white)),
        IconButton(onPressed: () => message('Ajuda', 'Central de ajuda demonstrativa.'), icon: const Icon(Icons.help_outline, color: Colors.white)),
        IconButton(onPressed: statement, icon: const Icon(Icons.receipt_long_outlined, color: Colors.white)),
      ]),
    ]),
    const SizedBox(height: 25), Text('Olá, $username', style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600)),
    const SizedBox(height: 12), Container(padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5), decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(20)), child: const Text('AMBIENTE DEMO • DADOS FICTÍCIOS', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold))),
  ]));

  Widget roundIcon(IconData icon, VoidCallback tap) => Material(color: Colors.white24, shape: const CircleBorder(), child: InkWell(customBorder: const CircleBorder(), onTap: tap, child: SizedBox(width: 42, height: 42, child: Icon(icon, color: Colors.white))));

  Widget accountCard() => InkWell(onTap: statement, child: Padding(padding: const EdgeInsets.fromLTRB(24, 22, 24, 18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Row(children: [Text('Conta', style: TextStyle(fontSize: 16, color: ink, fontWeight: FontWeight.w500)), Spacer(), Icon(Icons.chevron_right, color: muted)]),
    const SizedBox(height: 16), Text(showValues ? money(balance) : '••••••', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: ink)),
    const SizedBox(height: 7), const Text('Toque para abrir o extrato demo', style: TextStyle(fontSize: 11, color: muted)),
  ])));

  Widget quickActions() {
    final actions = <(String, IconData, VoidCallback)>[
      ('Pix', Icons.qr_code_2, pix), ('Pagar', Icons.qr_code_scanner, () => message('Pagar • demo', 'Ação apenas ilustrativa; nenhum pagamento será processado.')),
      ('Transferir', Icons.swap_horiz, transfer), ('Depositar', Icons.south_west, () => message('Depositar • demo', 'Área demonstrativa.')),
      ('Empréstimos', Icons.person_outline, () => message('Empréstimos', 'Simulação visual.')), ('Recarga de celular', Icons.phone_android, () => message('Recarga • demo', 'Nenhuma recarga será realizada.')),
      ('Cobrar', Icons.call_made, () => message('Cobrar • demo', 'Cobrança apenas ilustrativa.')), ('Doação', Icons.favorite_border, () => message('Doação • demo', 'Nenhuma doação será enviada.')),
      ('Encontrar atalhos', Icons.grid_view, settings),
    ];
    return SingleChildScrollView(scrollDirection: Axis.horizontal, physics: const BouncingScrollPhysics(), child: Row(children: [
      const SizedBox(width: 20),
      for (final a in actions) Padding(padding: const EdgeInsets.only(right: 10), child: SizedBox(width: 76, child: Column(children: [
        Material(color: pale, shape: const CircleBorder(), child: InkWell(customBorder: const CircleBorder(), onTap: a.$3, child: SizedBox(width: 64, height: 64, child: Icon(a.$2, color: ink, size: 25)))),
        const SizedBox(height: 8), Text(a.$1, textAlign: TextAlign.center, maxLines: 2, style: const TextStyle(fontSize: 11, height: 1.25, color: ink, fontWeight: FontWeight.w500)),
      ]))),
      const SizedBox(width: 12),
    ]));
  }

  Widget myCards() => Padding(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20), child: Material(color: pale, borderRadius: BorderRadius.circular(10), child: InkWell(borderRadius: BorderRadius.circular(10), onTap: () => message('Meus cartões', 'Visualização demonstrativa.'), child: const Padding(padding: EdgeInsets.all(15), child: Row(children: [Icon(Icons.credit_card_outlined, color: ink), SizedBox(width: 12), Text('Meus cartões', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: ink))])))));

  Widget promos() => SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [
    const SizedBox(width: 24), promo('Você tem R\$ 10.000,00 disponíveis para ', 'empréstimo.'), promo('Conquiste planos futuros: conheça as opções para ', 'guardar dinheiro.'), const SizedBox(width: 10),
  ]));

  Widget promo(String a, String b) => Container(width: 280, margin: const EdgeInsets.only(right: 14), decoration: BoxDecoration(color: pale, borderRadius: BorderRadius.circular(10)), child: InkWell(onTap: () => message('Conheça', 'Conteúdo demonstrativo.'), child: Padding(padding: const EdgeInsets.all(25), child: RichText(maxLines: 2, overflow: TextOverflow.ellipsis, text: TextSpan(style: const TextStyle(color: ink, fontSize: 14, height: 1.4), children: [TextSpan(text: a), TextSpan(text: b, style: const TextStyle(color: purple, fontWeight: FontWeight.w600))])))));

  Widget feature(String title, String description, String value, String extra, IconData icon, VoidCallback tap) => InkWell(onTap: tap, child: Padding(padding: const EdgeInsets.fromLTRB(24, 22, 24, 22), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Icon(icon, color: muted, size: 22), const SizedBox(width: 16),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: ink)), const SizedBox(height: 18),
      if (value.isNotEmpty) ...[
        Text(description, style: const TextStyle(fontSize: 13, color: muted, fontWeight: FontWeight.w500)), const SizedBox(height: 6),
        if (showValues) Text(value, style: const TextStyle(fontSize: 22, color: ink, fontWeight: FontWeight.w700)) else Container(height: 28, width: 150, color: pale),
        if (extra.isNotEmpty) ...[const SizedBox(height: 5), Text(extra, style: const TextStyle(fontSize: 12, color: muted))],
      ] else Text(description, style: const TextStyle(fontSize: 13, color: muted, height: 1.5, fontWeight: FontWeight.w500)),
    ])),
    const Icon(Icons.chevron_right, color: muted),
  ])));

  Widget discover() => SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [
    const SizedBox(width: 24), discoverCard('WhatsApp', 'Pagamentos seguros, rápidos e sem tarifa. Uma experiência prática sem sair da conversa.', 'Quero conhecer', true),
    discoverCard('Indique seus amigos', 'Mostre aos seus amigos como é fácil ter uma vida sem burocracia.', 'Indicar amigos', false), const SizedBox(width: 14),
  ]));

  Widget discoverCard(String title, String content, String button, bool isNew) => Container(width: 300, margin: const EdgeInsets.only(right: 15), decoration: BoxDecoration(color: pale, borderRadius: BorderRadius.circular(10)), child: InkWell(onTap: () => message(title, 'Conteúdo demonstrativo.'), child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(children: [Flexible(child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: ink))), if (isNew) ...[const SizedBox(width: 5), Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: purple, borderRadius: BorderRadius.circular(5)), child: const Text('Novo', style: TextStyle(color: Colors.white, fontSize: 10)))]]),
    const SizedBox(height: 10), Text(content, maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: muted, height: 1.5)),
    const SizedBox(height: 18), Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9), decoration: BoxDecoration(color: purple, borderRadius: BorderRadius.circular(22)), child: Text(button, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600))),
  ]))));

  Widget field(TextEditingController c, String label, {String? hint, IconData? icon, TextInputType keyboard = TextInputType.text}) => TextField(controller: c, keyboardType: keyboard, decoration: InputDecoration(labelText: label, hintText: hint, prefixIcon: icon == null ? null : Icon(icon), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: purple, width: 1.5))));

  Widget detail(String label, String value) => Padding(padding: const EdgeInsets.symmetric(vertical: 7), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    SizedBox(width: 132, child: Text(label, style: const TextStyle(color: muted))), Expanded(child: Text(value.isEmpty ? 'Não informado' : value, style: const TextStyle(color: ink, fontWeight: FontWeight.w600))),
  ]));
}

class DemoBanner extends StatelessWidget {
  const DemoBanner({super.key});
  @override
  Widget build(BuildContext context) => Container(width: double.infinity, padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFFF4EAFE), borderRadius: BorderRadius.circular(10)), child: const Text('SIMULAÇÃO — este aplicativo é apenas demonstrativo. Não envia Pix, não realiza transferências e não movimenta dinheiro real.', style: TextStyle(fontSize: 11, color: Color(0xFF5D2480), height: 1.4)));
}
