import Blob "mo:base/Blob";
import Cycles "mo:base/ExperimentalCycles";
import Text "mo:base/Text";
import Types "Types";

actor {

  public func get_icp_usd_exchange() : async Text {
    let ic : Types.IC = actor ("aaaaa-aa");

    let host : Text = "api.exchange.coinbase.com";
    let url = "https://" # host # "/products/BTC-USD/candles?granularity=3600&start=2022-01-01T00:00:00Z&end=2022-01-02T00:00:00Z";

    let request_headers = [
        { name = "Host"; value = host # ":443" },
        { name = "User-Agent"; value = "exchange_rate_canister" },
    ];

    let transform_context : Types.TransformContext = {
      function = transform;
      context = Blob.fromArray([]);
    };

    let http_request : Types.HttpRequestArgs = {
        url = url;
        max_response_bytes = null;
        headers = request_headers;
        body = null;
        method = #get;
        transform = ?transform_context;
    };

    Cycles.add(20_949_972_000);

    let http_response : Types.HttpResponsePayload = await ic.http_request(http_request);

    let response_body: Blob = Blob.fromArray(http_response.body);
    let decoded_text: Text = switch (Text.decodeUtf8(response_body)) {
        case (null) { "No value returned" };
        case (?y) { y };
    };

    decoded_text
  };

  public query func transform(raw : Types.TransformArgs) : async Types.CanisterHttpResponsePayload {
      let transformed : Types.CanisterHttpResponsePayload = {
          status = raw.response.status;
          body = raw.response.body;
          headers = [
              { name = "Content-Security-Policy"; value = "default-src 'self'" },
              { name = "Referrer-Policy"; value = "strict-origin" },
              { name = "Permissions-Policy"; value = "geolocation=(self)" },
              { name = "Strict-Transport-Security"; value = "max-age=63072000" },
              { name = "X-Frame-Options"; value = "DENY" },
              { name = "X-Content-Type-Options"; value = "nosniff" },
          ];
      };
      transformed;
  };
};
