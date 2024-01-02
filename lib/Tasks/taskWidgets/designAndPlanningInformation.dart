import 'package:flutter/material.dart';

class DesignAndPlanningInformation extends StatefulWidget {
  final String title;
  final String documentName1;
  final String document1;
  final String documentName2;
  final String document2;

  DesignAndPlanningInformation({
    Key? key,
    required this.title,
    required this.documentName1,
    required this.document1,
    required this.documentName2,
    required this.document2,
  }) : super(key: key);

  @override
  State<DesignAndPlanningInformation> createState() => _DesignAndPlanningInformationState();
}

class _DesignAndPlanningInformationState extends State<DesignAndPlanningInformation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Card(
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,  // Adjusted to wrap content
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 17,
              decoration: BoxDecoration(
                color: const Color(0xFF6781A6),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                border: Border.all(
                  color: const Color(0xFF2F4771),
                  width: 1.0,
                ),
              ),
              child: Center(
                child: Text(
                  widget.title,
                  style: const TextStyle(
                      color: Color(0xFFF9FAFB),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDocumentRow(widget.documentName1),
                  const SizedBox(height: 10),  // Added for spacing
                  _buildDocumentRow(widget.documentName2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentRow(String documentName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(  // Expanded to fit text in available space
          child: Text(
            documentName,
            style: TextStyle(
                color: Color(0xFF2F4771),
                fontWeight: FontWeight.w500,
                fontSize: 16
            ),
            overflow: TextOverflow.ellipsis,  // Added to prevent overflow
          ),
        ),
        _buildButton(Icons.file_open_outlined, "Open"),
        _buildButton(Icons.sim_card_download_outlined, "Download"),
      ],
    );
  }

  Widget _buildButton(IconData icon, String label) {
    return Container(
      margin: const EdgeInsets.only(left: 5),
      height: 35,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Color(0xFF2F4771),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Color(0xFFF9FAFB)),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: Color(0xFFF9FAFB),
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
