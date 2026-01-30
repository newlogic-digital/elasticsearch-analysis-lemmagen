# Change notes
## 2026-01-30
- Updated Elasticsearch/plugin versions to 9.2.4 and Lucene to 10.3.2.
- Set build and plugin descriptor to Java 21; refreshed compiler/surefire plugin versions.
- Adjusted tests to let AnalysisTestsHelper set index version (removed Version.CURRENT).
- Tests not run locally (Java 21 not available).
