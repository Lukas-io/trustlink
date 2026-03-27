import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class HowToUseScreen extends StatelessWidget {
  const HowToUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("How Trustlink Works"),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
        children: [
          // ── Intro ──
          const Text(
            "Trustlink holds money in escrow so neither side has to take a leap of faith. "
            "The seller knows the money is real. The buyer knows it won't be released until they say so.",
            style: TextStyle(
              fontSize: 15,
              height: 1.5,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 28),

          // ── 1. Getting Started ──
          _FlowSection(
            icon: Icons.person_add_outlined,
            iconBg: AppColors.primary,
            title: "Getting Started",
            why: "Your account is how Trustlink knows where to send money and who to notify.",
            steps: const [
              _Step(
                heading: "Sign up with your email",
                body: "You'll get a verification code. Enter it — that's how we know the email is yours.",
              ),
              _Step(
                heading: "Set your 4-digit PIN",
                body:
                    "This PIN confirms every transaction you make. Don't share it. "
                    "If someone has your PIN and your email, they can move your money.",
              ),
              _Step(
                heading: "You're in",
                body:
                    "No KYC forms, no long waits. You can start sending and receiving immediately.",
              ),
            ],
          ),

          // ── 2. Funding Your Wallet ──
          _FlowSection(
            icon: Icons.account_balance_wallet_outlined,
            iconBg: AppColors.secondary,
            title: "Funding Your Wallet",
            why: "You need money in your wallet before you can pay into escrow or transfer to anyone.",
            steps: const [
              _Step(
                heading: "Tap Fund Wallet on your dashboard",
                body:
                    "You'll see a payment page powered by Kora Pay. Use your card or bank transfer.",
                action: "Tap → Fund Wallet",
              ),
              _Step(
                heading: "Money lands in seconds",
                body:
                    "Once the payment clears, your balance updates. No manual confirmation needed.",
              ),
            ],
          ),

          // ── 3. Selling — Creating an Escrow ──
          _FlowSection(
            icon: Icons.storefront_outlined,
            iconBg: AppColors.orange,
            title: "Selling Something",
            why:
                "You want to get paid, but the buyer doesn't want to send money to a stranger. "
                "Escrow solves that. The money sits in the middle until the deal is done.",
            steps: const [
              _Step(
                heading: "Create a payment link",
                body:
                    "Set the amount and describe what you're selling. Be specific — "
                    "\"Hand-painted portrait, 24×36 inches\" is better than \"art\".",
                action: "Tap → Create Link",
              ),
              _Step(
                heading: "Share the link with your buyer",
                body:
                    "Send it over WhatsApp, DM, email — however you talk to your customers. "
                    "They don't need a Trustlink account to pay.",
              ),
              _Step(
                heading: "Wait for payment",
                body:
                    "The transaction shows up as Pending on your dashboard once the buyer pays. "
                    "The money is locked in escrow. You can't touch it yet — and that's the point.",
              ),
            ],
          ),

          // ── 4. Buying — Paying into Escrow ──
          _FlowSection(
            icon: Icons.shopping_bag_outlined,
            iconBg: AppColors.primary,
            title: "Buying Something",
            why:
                "You're paying a seller you may not know personally. "
                "Escrow means your money is protected until you confirm you got what you paid for.",
            steps: const [
              _Step(
                heading: "Open the payment link",
                body:
                    "The seller sends you a link. It shows the amount, description, and who you're paying.",
              ),
              _Step(
                heading: "Pay from your wallet",
                body:
                    "If you have enough balance, the payment is instant. "
                    "If not, fund your wallet first.",
                action: "Tap → Pay Now",
              ),
              _Step(
                heading: "Your money is now in escrow",
                body:
                    "The seller can see the payment, but can't withdraw it. "
                    "You stay in control until you confirm delivery.",
              ),
            ],
          ),

          // ── 5. Confirming Delivery ──
          _FlowSection(
            icon: Icons.verified_outlined,
            iconBg: const Color(0xFF065F46),
            title: "Confirming Delivery",
            why:
                "This is the moment the seller gets paid. Only do this when you've received "
                "what you ordered and you're satisfied.",
            steps: const [
              _Step(
                heading: "Check your email for the verification PIN",
                body:
                    "When you paid into escrow, a 4-digit PIN was sent to your email. "
                    "This PIN is your proof that the release was intentional.",
              ),
              _Step(
                heading: "Open the transaction and tap Verify Payment",
                body:
                    "Enter the PIN. That's it. Funds move to the seller's wallet immediately.",
                action: "Tap → Verify Payment → Enter PIN",
              ),
              _Step(
                heading: "Transaction marked as Completed",
                body: "Both sides get a confirmation. The deal is done.",
              ),
            ],
          ),

          // ── 6. Requesting a Refund ──
          _FlowSection(
            icon: Icons.replay_rounded,
            iconBg: AppColors.error,
            title: "If Something Goes Wrong",
            why:
                "Maybe the seller didn't deliver what they promised. Maybe you changed your mind before delivery. "
                "Either way, you can request your money back.",
            steps: const [
              _Step(
                heading: "Open the transaction and tap Request Refund",
                body:
                    "Write a short reason. Attach proof if you have it — a screenshot, a photo, whatever makes your case clear.",
                action: "Tap → Request Refund",
              ),
              _Step(
                heading: "The seller gets notified",
                body:
                    "The transaction status changes to Cancelled. "
                    "The seller receives a refund PIN by email.",
              ),
              _Step(
                heading: "Seller confirms the refund",
                body:
                    "The seller enters their PIN to release the funds back to you. "
                    "Once they do, the transaction is marked Refunded and the money returns to your wallet.",
              ),
              _Step(
                heading: "What if the seller won't confirm?",
                body:
                    "Reach out to them directly. Trustlink holds the funds — "
                    "neither side can access the money until the refund is confirmed or the dispute is resolved.",
              ),
            ],
            isLast: true,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Flow Section
// ─────────────────────────────────────────────────────────────────────────────

class _FlowSection extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final String title;
  final String why;
  final List<_Step> steps;
  final bool isLast;

  const _FlowSection({
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.why,
    required this.steps,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconBg.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 20, color: iconBg),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Why it matters
          Text(
            why,
            style: const TextStyle(
              fontSize: 14,
              height: 1.45,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 14),
          // Steps
          ...steps.asMap().entries.map((entry) {
            final i = entry.key;
            final step = entry.value;
            return _StepTile(
              number: i + 1,
              heading: step.heading,
              body: step.body,
              action: step.action,
            );
          }),
          if (!isLast)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Divider(
                color: AppColors.outline.withOpacity(0.2),
                height: 1,
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Step data
// ─────────────────────────────────────────────────────────────────────────────

class _Step {
  final String heading;
  final String body;
  final String? action;

  const _Step({
    required this.heading,
    required this.body,
    this.action,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// Step tile
// ─────────────────────────────────────────────────────────────────────────────

class _StepTile extends StatelessWidget {
  final int number;
  final String heading;
  final String body;
  final String? action;

  const _StepTile({
    required this.number,
    required this.heading,
    required this.body,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Center(
              child: Text(
                "$number",
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  heading,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.45,
                  ),
                ),
                if (action != null) ...[
                  const SizedBox(height: 6),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      action!,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
