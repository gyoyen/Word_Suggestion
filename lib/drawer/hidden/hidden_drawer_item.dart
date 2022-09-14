//tried and then abandoned. you can delete this class

/*class HiddenDrawerItem extends StatefulWidget {
  const HiddenDrawerItem(
      {Key? key,
      required this.isFirstItem,
      required this.buttonWidth,
      required this.label,
      required this.icn,
      required this.onPressFnc,
      required this.cnt})
      : super(key: key);

  final bool isFirstItem;
  final double buttonWidth;
  final String label;
  final Icon icn;
  final Function onPressFnc;
  final SimpleHiddenDrawerController cnt;

  @override
  State<HiddenDrawerItem> createState() => _HiddenDrawerItemState();
}

class _HiddenDrawerItemState extends State<HiddenDrawerItem> {
  late SimpleHiddenDrawerController _controller;

  @override
  void initState() {
    _controller = widget.cnt;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.isFirstItem == true
          ? EdgeInsets.fromLTRB(
              0, MediaQuery.of(context).size.height * 0.07, 0, 0)
          : EdgeInsets.fromLTRB(
              0, MediaQuery.of(context).size.height * 0.03, 0, 0),
      child: SizedBox(
        //width: MediaQuery.of(context).size.width * 0.6,
        width: widget.buttonWidth,
        child: ElevatedButton.icon(
          icon: widget.icn,
          style: ElevatedButton.styleFrom(
            alignment: Alignment.centerLeft,
            backgroundColor: Colors.grey[300],
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.horizontal(
                left: Radius.zero,
                right: Radius.circular(20),
              ),
            ),
          ),
          onPressed: () /*=> widget.onPressFnc,*/
              {
            _controller.setSelectedMenuPosition(2);
          },
          label: Text(
            widget.label,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}*/
