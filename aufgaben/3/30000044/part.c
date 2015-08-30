/*
 * part.c -- partial regex match
 *
 * (c) 2015 Prof Dr Andreas Mueller, Hochschule Rapperswil
 */
#include <regex.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

const char	*r2 = "^(([0-9]+)|x([0-9]+))$";

int	main(int argc, char *argv[]) {
	int	rc;
	/* compile regex */
	regex_t	regex;
	rc = regcomp(&regex, r2, REG_EXTENDED);
	if (rc) {
		char	errbuf[1024];
		regerror(rc, &regex, errbuf, sizeof(errbuf));
		fprintf(stderr, "cannot compile regex: %s\n", errbuf);
		return EXIT_FAILURE;
	}

	/* match each line of the input */
	char	buffer[128];
	while (fgets(buffer, sizeof(buffer), stdin)) {
		regmatch_t	matches[4];
		if (buffer[strlen(buffer) - 1] == '\n') {
			buffer[strlen(buffer) - 1] = '\0';
		}
		printf("matching: '%s' ==> ", buffer);
		if (REG_NOMATCH == regexec(&regex, buffer, 4, matches, 0)) {
			printf("no match\n");
			continue;
		}
		/* find out which part of the expression matched */
		if (matches[2].rm_so != -1) {
			printf("width: %*s\n",
				matches[2].rm_eo - matches[2].rm_so,
				&buffer[matches[2].rm_so]);
		} else if (matches[3].rm_so != -1) {
			printf("height: %*s\n",
				matches[3].rm_eo - matches[3].rm_so,
				&buffer[matches[3].rm_so]);
		} else {
			fprintf(stderr, "internal error\n");
		}
	}

	/* cleanup */
	regfree(&regex);

	return EXIT_SUCCESS;
}
