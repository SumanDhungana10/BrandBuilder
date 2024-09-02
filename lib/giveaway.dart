import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add this for time formatting
import 'dart:async';

class Giveaway extends StatefulWidget {
  const Giveaway({
    super.key,
    required this.template,
    required this.title,
    required this.description,
    this.timestamp,
    this.image,
    required this.isTepmlate1,
  });
  final String template;
  final String title;
  final String description;
  final String? timestamp;
  final String? image;
  final bool isTepmlate1;

  @override
  State<Giveaway> createState() => _GiveawayState();
}

class _GiveawayState extends State<Giveaway> {
  late String countdownTime;
  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();
    // countdownTime =
    //     widget.timestamp!.isNotEmpty ? _formatTime() : "Default Time";
    if (widget.timestamp != null && widget.timestamp!.isNotEmpty) {
      countdownTime = _formatTime();
      _startCountdown();
    }
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        countdownTime = _formatTime();
        if (countdownTime == "00:00:00") {
          countdownTimer?.cancel();
        }
      });
    });
  }

  String _formatTime() {
    DateTime giveawayEndTime =
        DateFormat("yyyy-MM-dd HH:mm:ss").parse(widget.timestamp!);
    Duration remainingTime = giveawayEndTime.difference(DateTime.now());

    if (remainingTime.isNegative) {
      return "00:00:00";
    } else {
      int totalHours = remainingTime.inHours;
      String hours = totalHours.toString().padLeft(2, '0');
      String minutes =
          remainingTime.inMinutes.remainder(60).toString().padLeft(2, '0');
      String seconds =
          remainingTime.inSeconds.remainder(60).toString().padLeft(2, '0');
      return "$hours:$minutes:$seconds";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFE5E5E5),
            width: 1,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("1. Giveaway Offers",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  )),
              const SizedBox(height: 16),
              widget.isTepmlate1 ? _buildTemplate1() : _buildTemplate2(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTemplate1() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE5E5E5),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.template,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(height: 8),
            Container(
              width: 310,
              height: 180,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(5.5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFC107),
                        borderRadius: BorderRadius.circular(2.76),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 0),
                      child: (widget.timestamp == null)
                          ? const Text("Time Status",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFFFFFFF),
                              ))
                          : Text("Time left: $countdownTime",
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFFFFFFF),
                              )),
                    ),
                    Center(
                      child: Text(widget.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF151515),
                          )),
                    ),
                    Text(widget.description,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF151515),
                        )),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(8.27),
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF454545),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.76),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("ENTER TO WIN"),
                          Icon(Icons.arrow_forward_outlined),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTemplate2() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE5E5E5),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.template,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(height: 8),
            Container(
              width: 310,
              height: 180,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(5.5),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(widget.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF151515),
                              )),
                          const SizedBox(height: 5),
                          Text(widget.description,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF151515),
                              )),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(8.27),
                              foregroundColor: Colors.white,
                              backgroundColor: const Color(0xFF454545),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.76),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("ENTER TO WIN"),
                                Icon(Icons.arrow_forward_outlined),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFC107),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5.5),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 0),
                          child: Center(
                            child: (widget.timestamp == null)
                                ? const Text("Time Status",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFFFFFFFF),
                                    ))
                                : Text("Time left: $countdownTime",
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFFFFFFFF),
                                    )),
                          ),
                        ),
                        (widget.image != null)
                            ? Expanded(
                                child: Image.network(widget.image!,
                                    fit: BoxFit.cover),
                              )
                            : Expanded(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFCF4E9),
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(5.5),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text('Image',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF151515),
                                        )),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
