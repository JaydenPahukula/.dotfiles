# validates and formats the 'hosts' attrset in flake.nix
let
  assertFn = pred: msg: e: assert pred || throw "in flake.nix: ${msg}"; e;
  validHostTypes = ["desktop" "server"];
in
  builtins.mapAttrs (
    name: host:
      assertFn (host ? "system") "hosts.\"${name}\" is missing required attribute 'system'"
      assertFn (builtins.typeOf host.system == "string") "hosts.\"${name}\".system must be a string"
      assertFn (host ? "stateVersion") "hosts.\"${name}\" is missing required attribute 'stateVersion'"
      assertFn (builtins.typeOf host.stateVersion == "string") "hosts.\"${name}\".stateVersion must be a string"
      assertFn (host ? "type") "hosts.\"${name}\" is missing required attribute 'type'"
      assertFn (builtins.elem host.type validHostTypes) "hosts.\"${name}\".type should be one of: ${builtins.concatStringsSep ", " (builtins.map (x: "\"${x}\"") validHostTypes)}"
      (host // {inherit name;})
  )
