class HuffmanNode {
  late String data;
  late int frequency;
  HuffmanNode? left, right;

  HuffmanNode(this.data, this.frequency);

  bool isLeaf() {
    return left == null && right == null;
  }
}

class Huffman {
  HuffmanNode buildTree(Map<String, int> frequencies) {
    List<HuffmanNode> nodes = [];

    frequencies.forEach((char, frequency) {
      nodes.add(HuffmanNode(char, frequency));
    });

    while (nodes.length > 1) {
      nodes.sort((a, b) => a.frequency.compareTo(b.frequency));

      HuffmanNode left = nodes.removeAt(0);
      HuffmanNode right = nodes.removeAt(0);

      HuffmanNode parent = HuffmanNode('\0', left.frequency + right.frequency);
      parent.left = left;
      parent.right = right;

      nodes.add(parent);
    }

    return nodes[0];
  }

  Map<String, String> generateCodes(HuffmanNode root, String code, Map<String, String> codes) {
    if (root.isLeaf()) {
      codes[root.data] = code;
    } else {
      generateCodes(root.left!, code + '0', codes);
      generateCodes(root.right!, code + '1', codes);
    }
    return codes;
  }

  String encode(String message) {
    final Map<String, int> frequencies = count(message);
    final HuffmanNode root = buildTree(frequencies);
    final Map<String, String> codes = generateCodes(root, '', {});

    // Encode the text using the generated codes
    String encodedText = '';
    for (int i = 0; i < message.length; i++) {
      encodedText += codes[message[i]]!;
    }

    return encodedText;
  }

  String decode(String encodedText, String message) {
    String decodedText = '';
    HuffmanNode current = buildTree(count(message));

    for (int i = 0; i < encodedText.length; i++) {
      if (encodedText[i] == '0') {
        current = current.left!;
      } else {
        current = current.right!;
      }

      if (current.isLeaf()) {
        decodedText += current.data;
        current = buildTree(count(message));
      }
    }

    return decodedText;
  }

  Map<String, int> count(String message) {
    Map<String, int> freq = {};

    final characters = message.split('');

    for (String character in characters) {
      freq[character] = freq[character] != null ? freq[character]! + 1 : 1;
    }

    return freq;
  }
}

void main() {
  Huffman huffman = Huffman();
  String message = 'Apollo';

  // Encode the message using Huffman coding
  String encodedMessage = huffman.encode(message);
  print('Original message: $message');
  print('Encoded message: $encodedMessage');

  // Decode the encoded message
  String decodedMessage = huffman.decode(encodedMessage, message);
  print('Decoded message: $decodedMessage');
}
