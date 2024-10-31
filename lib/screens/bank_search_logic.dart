import 'package:flutter/material.dart';

class BankSearchLogic extends StatefulWidget {
  const BankSearchLogic({super.key});

  @override
  State<BankSearchLogic> createState() => _BankSearchLogicState();
}

class _BankSearchLogicState extends State<BankSearchLogic> {
  final TextEditingController _controller = TextEditingController();
  List<String> _filteredBanks = [];
  String? errorText;

  final List<String> _allBanks = [
    'State Bank of India',
    'Bank of Baroda',
    'Punjab National Bank',
    'Axis Bank',
    'HDFC Bank',
    'ICICI Bank',
    'Canara Bank',
    'Union Bank of India',
    'Indian Bank',
    'Bank of Maharashtra',
    'IDBI Bank',
    'UCO Bank',
    'Central Bank of India',
    'Indian Overseas Bank',
    'Kotak Mahindra Bank',
    'Yes Bank',
    'Federal Bank',
    'South Indian Bank',
    'RBL Bank',
    'IndusInd Bank',
    'Dhanlaxmi Bank',
    'City Union Bank',
    'Karur Vysya Bank',
    'Lakshmi Vilas Bank',
    'Jammu & Kashmir Bank',
    'Bandhan Bank',
    'IDFC First Bank',
    'Standard Chartered Bank',
    'Deutsche Bank',
    'HSBC Bank',
  ];

  void _bankFilter(String query) {
    // filter out all banks which contain given query
    List<String> filtered = _allBanks
        .where(
          (element) => element.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();

    // sort banks w.r.t index from which given query starts
    filtered.sort(
      (a, b) {
        return (a
            .toLowerCase()
            .indexOf(query.toLowerCase())
            .compareTo(b.toLowerCase().indexOf(query.toLowerCase())));
      },
    );

    // sort the groups of banks alphabetically where query is at same index
    filtered.sort(
      (a, b) {
        if (a.toLowerCase().indexOf(query.toLowerCase()) ==
            b.toLowerCase().indexOf(query.toLowerCase())) {
          return (a.toLowerCase().compareTo(b.toLowerCase()));
        } else {
          return 0;
        }
      },
    );
    setState(() {
      if (query.isEmpty) {
        _filteredBanks = [];
        filtered = [];
        errorText = null;
      } else if (filtered.isEmpty) {
        errorText = 'No Result Found';
        _filteredBanks = [];
      } else {
        errorText = null;
        _filteredBanks = filtered;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Search for Bank',
                  errorText: errorText,
                ),
                onChanged: (value) {
                  _bankFilter(value);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: _filteredBanks.length,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text(_filteredBanks[index]));
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
