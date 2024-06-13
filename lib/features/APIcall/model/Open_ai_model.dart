// To parse this JSON data, do
//
//     final openAiRes = openAiResFromJson(jsonString);

import 'dart:convert';

OpenAiRes openAiResFromJson(String str) => OpenAiRes.fromJson(json.decode(str));

String openAiResToJson(OpenAiRes data) => json.encode(data.toJson());

class OpenAiRes {
    String? id;
    String? object;
    int? created;
    String? model;
    String? systemFingerprint;
    List<Choice>? choices;
    Usage? usage;

    OpenAiRes({
        this.id,
        this.object,
        this.created,
        this.model,
        this.systemFingerprint,
        this.choices,
        this.usage,
    });

    factory OpenAiRes.fromJson(Map<String, dynamic> json) => OpenAiRes(
        id: json["id"],
        object: json["object"],
        created: json["created"],
        model: json["model"],
        systemFingerprint: json["system_fingerprint"],
        choices: json["choices"] == null ? [] : List<Choice>.from(json["choices"]!.map((x) => Choice.fromJson(x))),
        usage: json["usage"] == null ? null : Usage.fromJson(json["usage"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "created": created,
        "model": model,
        "system_fingerprint": systemFingerprint,
        "choices": choices == null ? [] : List<dynamic>.from(choices!.map((x) => x.toJson())),
        "usage": usage?.toJson(),
    };
}

class Choice {
    int? index;
    Message? message;
    dynamic logprobs;
    String? finishReason;

    Choice({
        this.index,
        this.message,
        this.logprobs,
        this.finishReason,
    });

    factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        index: json["index"],
        message: json["message"] == null ? null : Message.fromJson(json["message"]),
        logprobs: json["logprobs"],
        finishReason: json["finish_reason"],
    );

    Map<String, dynamic> toJson() => {
        "index": index,
        "message": message?.toJson(),
        "logprobs": logprobs,
        "finish_reason": finishReason,
    };
}

class Message {
    String? role;
    String? content;

    Message({
        this.role,
        this.content,
    });

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        role: json["role"],
        content: json["content"],
    );

    Map<String, dynamic> toJson() => {
        "role": role,
        "content": content,
    };
}

class Usage {
    int? promptTokens;
    int? completionTokens;
    int? totalTokens;

    Usage({
        this.promptTokens,
        this.completionTokens,
        this.totalTokens,
    });

    factory Usage.fromJson(Map<String, dynamic> json) => Usage(
        promptTokens: json["prompt_tokens"],
        completionTokens: json["completion_tokens"],
        totalTokens: json["total_tokens"],
    );

    Map<String, dynamic> toJson() => {
        "prompt_tokens": promptTokens,
        "completion_tokens": completionTokens,
        "total_tokens": totalTokens,
    };
}
