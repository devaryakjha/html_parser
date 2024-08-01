
# ================= COMMON =================
version-increment-major:
	@perl -i -pe 's/^(version:\s+)(\d+)(\.\d+\.\d+\+\d+)/$$1.($$2+1).".0.0+0"/e' pubspec.yaml

version-increment-minor:
	@perl -i -pe 's/^(version:\s+\d+\.)(\d+)(\.\d+\+\d+)/$$1.($$2+1).".0+0"/e' pubspec.yaml

version-increment-patch:
	@perl -i -pe 's/^(version:\s+\d+\.\d+\.)(\d+)(\+\d+)/$$1.($$2+1)."$$3"/e' pubspec.yaml

version-increment-build:
	@perl -i -pe 's/^(version:\s+\d+\.\d+\.\d+\+)(\d+)/$$1.($$2+1)/e' pubspec.yaml

commit-version-increment:
	git add pubspec.yaml
	git commit -m "Version increment"
	git push

version-increment: version-increment-patch version-increment-build commit-version-increment