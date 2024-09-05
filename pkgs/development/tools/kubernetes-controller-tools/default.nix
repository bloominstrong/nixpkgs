{ buildGoModule, lib, fetchFromGitHub }:

buildGoModule rec {
  pname = "controller-tools";
  version = "0.16.1";

  src = fetchFromGitHub {
    owner = "kubernetes-sigs";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-BPadZ9FVWnE/5OVYRyGZVGQQ4B3Is+HhUWcf3ZVS7jM=";
  };

  patches = [ ./version.patch ];

  vendorHash = "sha256-3p9K08WMqDRHHa9116//3lFeaMtRaipD4LyisaKWV7I=";

  ldflags = [
    "-s"
    "-w"
    "-X sigs.k8s.io/controller-tools/pkg/version.version=v${version}"
  ];

  doCheck = false;

  subPackages = [
    "cmd/controller-gen"
    "cmd/type-scaffold"
    "cmd/helpgen"
  ];

  meta = with lib; {
    description = "Tools to use with the Kubernetes controller-runtime libraries";
    homepage = "https://github.com/kubernetes-sigs/controller-tools";
    changelog = "https://github.com/kubernetes-sigs/controller-tools/releases/tag/v${version}";
    license = licenses.asl20;
    maintainers = with maintainers; [ michojel ];
  };
}
